{
  nix.gc = {
    automatic = true;
    dates = "02:00";
    options = "--delete-older-than 14d";
  };

  nix.optimise = {
    automatic = true;
    dates = ["02:15"];
  };
}
