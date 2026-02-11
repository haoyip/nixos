{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = ["imv.desktop"];
      "image/jpeg" = ["imv.desktop"];
      "image/webp" = ["imv.desktop"];
      "image/gif" = ["imv.desktop"];

      "text/plain" = ["neovide.desktop"];
      "text/markdown" = ["neovide.desktop"];
      "text/x-shellscript" = ["neovide.desktop"];
      "application/json" = ["neovide.desktop"];
      "application/yaml" = ["neovide.desktop"];

      "inode/directory" = ["yazi.desktop"];

      "application/pdf" = ["zen-beta.desktop"];
    };
  };
}
