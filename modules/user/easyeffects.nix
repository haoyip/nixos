{pkgs, ...}: {
  environment.systemPackages = [pkgs.easyeffects];

  systemd.user.services.easyeffects = {
    description = "Easyeffects daemon";

    wantedBy = ["graphical-session.target"];
    partOf = ["graphical-session.target" "pipewire.service"];
    after = ["graphical-session.target" "pipewire.service"];
    wants = ["pipewire.service"];

    serviceConfig = {
      ExecStart = "${pkgs.easyeffects}/bin/easyeffects --hide-window --service-mode";
      ExecStop = "${pkgs.easyeffects}/bin/easyeffects --quit";
      KillMode = "mixed";
      Restart = "on-failure";
      RestartSec = 5;
      TimeoutStopSec = 10;
    };
  };
}
