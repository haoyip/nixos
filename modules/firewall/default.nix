{
  networking.firewall = {
    enable = true;
    allowPing = true;

    allowedTCPPortRanges = [
      {
        from = 8000;
        to = 8010;
      }
    ];
  };
}
