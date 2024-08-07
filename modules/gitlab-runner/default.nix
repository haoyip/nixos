{config, ...}: {
  sops.secrets = {
    gitlab-runner-docker-token = {};
  };

  services.gitlab-runner = {
    enable = true;

    settings = builtins.fromTOML ''
      concurrent = 2
      check_interval = 0
      connection_max_age = "15m0s"
      shutdown_timeout = 0
    '';

    services.docker = {
      executor = "docker";
      dockerImage = "scratch";
      dockerVolumes = ["/cache" "/var/run/docker.sock:/var/run/docker.sock"];

      authenticationTokenConfigFile = builtins.toFile "config.sh" ''
        export CI_SERVER_URL="https://gitlab.com"
        export REGISTRATION_TOKEN="$(cat ${config.sops.secrets.gitlab-runner-docker-token.path})"
      '';
    };
  };
}
