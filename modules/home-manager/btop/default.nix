{pkgs, ...}: {
  programs.btop = {
    enable = true;
    package = pkgs.btop-rocm;

    settings = {
      color_theme = "gruvbox_material_dark";
      theme_background = true;
      update_ms = 500;
      vim_keys = true;
    };
  };
}
