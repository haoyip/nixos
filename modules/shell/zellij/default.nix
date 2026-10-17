{pkgs, username, ...}: let
  defaultLayout = pkgs.writeText "zellij-default.kdl" ''
    layout {
      default_tab_template {
        children
          pane size=1 borderless=true {
            plugin location="file://${pkgs.zjstatus}/bin/zjstatus.wasm" {
              format_left "{mode}"
              format_center "{tabs}"
              format_right  "#[fg=#626880,bold]{session}"
              format_space  ""

              border_enabled  "false"

              mode_normal        ""
              mode_locked        "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]LOCKED#[fg=#8caaee]"
              mode_resize        "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]RESIZE#[fg=#8caaee]"
              mode_pane          "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]PANE#[fg=#8caaee]"
              mode_tab           "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]TAB#[fg=#8caaee]"
              mode_scroll        "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]SCROLL#[fg=#8caaee]"
              mode_enter_search  "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]ENTER-SEARCH#[fg=#8caaee]"
              mode_search        "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]SEARCH#[fg=#8caaee]"
              mode_rename_tab    "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]RENAME-TAB#[fg=#8caaee]"
              mode_rename_pane   "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]RENAME-PANE#[fg=#8caaee]"
              mode_session       "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]SESSION#[fg=#8caaee]"
              mode_move          "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]MOVE#[fg=#8caaee]"
              mode_prompt        "#[fg=#8caaee]#[bg=#8caaee,fg=#292c3c,bold]PROPMT#[fg=#8caaee]"
              mode_tmux          "#[fg=#ef9f76]#[bg=#ef9f76,fg=#292c3c,bold]TMUX#[fg=#ef9f76]"

              tab_normal   "#[fg=#626880] {index}"
              tab_active   "#[fg=#c6d0f5,bold,italic] {index}"
            }
          }
      }
    }
  '';
in {
  environment.systemPackages = [pkgs.zellij];

  systemd.tmpfiles.rules = [
    "L+ /home/${username}/.config/zellij/config.kdl - - - - ${./config.kdl}"
    "L+ /home/${username}/.config/zellij/themes - - - - ${./themes}"
    "L+ /home/${username}/.config/zellij/layouts/default.kdl - - - - ${defaultLayout}"
  ];
}
