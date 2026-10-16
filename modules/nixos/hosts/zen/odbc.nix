{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    unixodbcDrivers.msodbcsql18
  ];

  environment.unixODBCDrivers = with pkgs.unixodbcDrivers; [
    msodbcsql18
  ];
}
