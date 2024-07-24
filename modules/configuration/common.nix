{
  pkgs,
  config,
  ...
}: {
  system.stateVersion = "23.11";

  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_zen;

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

  services.postgresql = {
    enable = true;
  };

  services.fwupd.enable = true;

  fonts = {
    fontconfig.enable = true;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      cantarell-fonts
      (nerdfonts.override {fonts = ["CascadiaCode"];})
    ];
  };

  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Kuala_Lumpur";

  i18n = {
    defaultLocale = "en_US.UTF-8";

    inputMethod = {
      enabled = "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-chinese-addons
          fcitx5-configtool
        ];
      };
    };
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  # Decrypt ta-password to /run/secrets-for-users/ so it can be used to create the user
  sops.secrets.hao-password.neededForUsers = true;

  # Required for password to be set via sops during system activation
  users.mutableUsers = false;

  users.users.hao = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.hao-password.path;
    shell = pkgs.fish;
    description = "hao";
    extraGroups = [
      "networkmanager"
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
