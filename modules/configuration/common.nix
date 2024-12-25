{pkgs, ...}: {
  system.stateVersion = "25.05";

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernel.sysctl = {
      "fs.inotify.max_user_instances" = 1000000;
      "fs.inotify.max_user_watches" = 1000000;
      "fs.inotify.max_queued_events" = 1000000;
    };
  };

  services.flatpak.enable = true;

  services.fwupd.enable = true;

  fonts = {
    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
      hinting.style = "slight";
    };

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fantasque-sans-mono
    ];
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];

  time.timeZone = "Asia/Kuala_Lumpur";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.hao = {
    isNormalUser = true;
    shell = pkgs.fish;
    description = "hao";
    extraGroups = [
      "wheel"
      "i2c"
    ];
  };

  programs.fish.enable = true;

  environment.sessionVariables = {
    # Hint electron apps to use wayland:
    NIXOS_OZONE_WL = "1";
  };

  environment.variables = {
    EDITOR = "nvim";
  };
}
