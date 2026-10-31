{pkgs, ...}: let
  audioMimeTypes = [
    "audio/mpeg"
    "audio/mp4"
    "audio/flac"
    "audio/ogg"
    "audio/opus"
    "audio/wav"
    "audio/x-wav"
    "audio/aac"
    "audio/x-m4a"
    "audio/x-mp3"
    "audio/x-flac"
    "audio/x-vorbis+ogg"
    "audio/x-opus+ogg"
    "audio/x-matroska"
    "audio/x-ms-wma"
    "audio/x-aiff"
    "audio/x-pn-realaudio"
    "audio/3gpp"
    "audio/3gpp2"
    "audio/x-mpeg"
    "audio/x-mpegurl"
    "audio/x-scpls"
    "audio/x-mod"
    "audio/x-s3m"
    "audio/x-xm"
    "audio/x-it"
    "audio/midi"
    "audio/x-midi"
  ];

  audioDefaults = builtins.listToAttrs (map (mime: {
      name = mime;
      value = ["mpv.desktop"];
    })
    audioMimeTypes);

  nvimGhostty = pkgs.writeShellScriptBin "nvim-ghostty" ''
    exec ${pkgs.ghostty}/bin/ghostty -e nvim "$@"
  '';

  nvimTerminal = pkgs.makeDesktopItem {
    name = "nvim-ghostty";
    desktopName = "nvim (ghostty)";
    genericName = "Text Editor";
    comment = "Edit text files in a terminal window";
    icon = "nvim";
    exec = "${nvimGhostty}/bin/nvim-ghostty %F";
    terminal = false;
    categories = ["Utility" "TextEditor" "Development"];

    mimeTypes = [
      "text/plain"
      "text/markdown"
      "text/x-shellscript"
      "text/x-log"
      "application/json"
      "application/yaml"
    ];
  };
in {
  environment.systemPackages = [nvimTerminal];

  xdg.mime.defaultApplications =
    audioDefaults
    // {
      "image/png" = ["imv.desktop"];
      "image/jpeg" = ["imv.desktop"];
      "image/webp" = ["imv.desktop"];
      "image/gif" = ["imv.desktop"];

      "text/plain" = ["nvim-ghostty.desktop"];
      "text/markdown" = ["nvim-ghostty.desktop"];
      "text/x-shellscript" = ["nvim-ghostty.desktop"];
      "text/x-log" = ["nvim-ghostty.desktop"];
      "application/json" = ["nvim-ghostty.desktop"];
      "application/yaml" = ["nvim-ghostty.desktop"];

      "inode/directory" = ["yazi.desktop"];

      "application/pdf" = ["floorp.desktop"];

      "x-scheme-handler/http" = ["floorp.desktop"];
      "x-scheme-handler/https" = ["floorp.desktop"];
      "text/html" = ["floorp.desktop"];
    };
}
