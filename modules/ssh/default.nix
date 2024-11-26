{config, ...}: {
  sops.secrets = {
    "private_keys/me_gitlab" = {
      owner = "hao";
    };

    "private_keys/me_github" = {
      owner = "hao";
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
    '';
  };
}
