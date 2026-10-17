{config, username, ...}: {
  sops.secrets = {
    "private_keys/me_gitlab" = {
      owner = username;
    };
    "private_keys/me_github" = {
      owner = username;
    };
    "private_keys/zen/to_b450" = {
      owner = username;
    };
  };

  programs.ssh = {
    extraConfig = ''
      Host gitlab
        HostName gitlab.com
        User git
        IdentityFile ${config.sops.secrets."private_keys/me_gitlab".path}
        Port 22

      Host github
        HostName github.com
        User git
        IdentityFile ${config.sops.secrets."private_keys/me_github".path}
        Port 22

      Host b450
        HostName 10.0.0.1
        User ${username}
        IdentityFile ${config.sops.secrets."private_keys/zen/to_b450".path}
        Port 22
    '';
  };
}
