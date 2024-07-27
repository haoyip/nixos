{
  services.samba = {
    enable = true;
    openFirewall = true;

    extraConfig = ''
      workgroup = WORKGROUP
      server string = b450
      netbios name = b450
      security = user
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user

      [media]
      path = /data/8tb_1/media/
      public = yes
      writable = no
    '';
  };
}
