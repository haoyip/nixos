{pkgs, ...}: {
  system.stateVersion = "25.11";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_6_19;

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

  services.fwupd.enable = true;

  fonts = {
    fontconfig = {
      enable = true;
      subpixel.rgba = "rgb";
      hinting.style = "slight";
    };

    packages = with pkgs; [
      liberation_ttf
      maple-mono.NF
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
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
      "networkmanager"
    ];
  };

  programs.fish.enable = true;

  environment.sessionVariables = {
    # Hint electron apps to use wayland:
    NIXOS_OZONE_WL = "1";
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";

    inputMethod = {
      enable = true;
      type = "fcitx5";

      fcitx5 = {
        waylandFrontend = true;

        addons = with pkgs; [
          qt6Packages.fcitx5-chinese-addons
          qt6Packages.fcitx5-configtool
        ];
      };
    };
  };

  programs.kdeconnect.enable = true;

  services.flatpak.enable = true;
}
