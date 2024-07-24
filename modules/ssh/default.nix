{
  programs.ssh = {
    extraConfig = ''
      Host gitlab
        HostName gitlab.com
        User git
        IdentityFile ~/.ssh/me_gitlab
        Port 22

      Host github
        HostName github.com
        User git
        IdentityFile ~/.ssh/me_github
        Port 22
    '';
  };
}
