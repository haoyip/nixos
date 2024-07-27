{
  sops.secrets = {
    "private_keys/me_gitlab" = {
      path = "/home/hao/.ssh/me_gitlab";
      owner = "hao";
    };

    "private_keys/me_github" = {
      path = "/home/hao/.ssh/me_github";
      owner = "hao";
    };
  };

  programs.ssh = {
    extraConfig = ''
      Host gitlab
        HostName gitlab.com
        User git
        IdentityFile /home/hao/.ssh/me_gitlab
        Port 22

      Host github
        HostName github.com
        User git
        IdentityFile /home/hao/.ssh/me_github
        Port 22
    '';
  };
}
