{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    unixODBCDrivers.msodbcsql18
  ];

  environment.unixODBCDrivers = with pkgs.unixODBCDrivers; [
    msodbcsql18
  ];
}
