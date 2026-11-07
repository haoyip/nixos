{
  config,
  username,
  ...
}: {
  sops.secrets = {
    "private_keys/me_github" = {
      owner = username;
    };
  };

  programs.ssh = {
    extraConfig = ''
      Host github
        HostName github.com
        User git
        IdentityFile ${config.sops.secrets."private_keys/me_github".path}
        Port 22
    '';
  };
}
