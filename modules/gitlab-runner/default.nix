{
  services.gitlab-runner = {
    enable = true;
    configFile = ./gitlab.toml;
  };
}
