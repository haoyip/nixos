let
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
in {
  xdg.mimeApps = {
    enable = true;
    defaultApplications =
      audioDefaults
      // {
        "image/png" = ["imv.desktop"];
        "image/jpeg" = ["imv.desktop"];
        "image/webp" = ["imv.desktop"];
        "image/gif" = ["imv.desktop"];

        "text/plain" = ["neovide.desktop"];
        "text/markdown" = ["neovide.desktop"];
        "text/x-shellscript" = ["neovide.desktop"];
        "text/x-log" = ["neovide.desktop"];
        "application/json" = ["neovide.desktop"];
        "application/yaml" = ["neovide.desktop"];

        "inode/directory" = ["yazi.desktop"];

        "application/pdf" = ["zen-beta.desktop"];

        "x-scheme-handler/http" = ["zen-beta.desktop"];
        "x-scheme-handler/https" = ["zen-beta.desktop"];
        "text/html" = ["zen-beta.desktop"];
      };
  };
}
