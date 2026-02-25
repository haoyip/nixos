function fish_greeting
end

fish_vi_key_bindings

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

starship init fish | source
zoxide init --cmd cd fish | source

export MANPAGER='nvim +Man!'

alias ls 'eza -l1 --icons'
alias cat bat
alias grep rg
alias jq jaq
alias cl wl-copy
alias http xh
alias sshx "TERM=xterm-256color ssh"
alias mpvhdr "ENABLE_HDR_WSI=1 mpv --vo=gpu-next --target-colorspace-hint --gpu-api=vulkan --gpu-context=x11vk"

# General abbr
abbr -a a php artisan
abbr -a d cdh
abbr -a j cd
abbr -a ji cdi
abbr -a e neovide --fork
abbr -a gg lazygit
abbr -a l ls
abbr -a la 'ls -la'
abbr -a m 'zellij -s $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; echo "")'
abbr -a n nix
abbr -a nf 'nix flake'
abbr -a sc systemctl
abbr -a scs 'systemctl status'
abbr -a t tldr
abbr -a tf tofu
abbr -a o open

# Git
abbr -a g git
abbr -a gt 'git checkout'
abbr -a ga 'git add'
abbr -a gaa 'git add .'
abbr -a gs 'git status'
abbr -a gc 'git commit -m'
abbr -a gm 'git merge'
abbr -a gp 'git push'
abbr -a gl 'git pull'
abbr -a gb 'git branch'
abbr -a gu 'git status'
abbr -a gog 'git log'
abbr -a gd 'git diff'
abbr -a gds 'git diff --staged'

# Cargo
abbr -a c cargo
abbr -a cr 'cargo run'
abbr -a cb 'cargo build'
abbr -a cf 'cargo fmt'
abbr -a ct 'cargo test'
abbr -a ce 'cargo expand'
abbr -a cc 'cargo check'

# Podman
abbr -a p podman
abbr -a pc 'podman compose'
abbr -a ps 'podman ps'
abbr -a pl 'podman logs'

function toggle_tldr --description 'Toggle tldr prefix on the current commandline'
    set cmd (commandline)

    if string match -q 'tldr *' -- $cmd
        # If it already starts with "tldr ", remove it
        set new_cmd (string replace -r '^tldr\s+' '' $cmd)
    else
        # Otherwise, prepend "tldr "
        set new_cmd "tldr $cmd"
    end

    commandline -r "$new_cmd"
    commandline -f repaint
end

# Bind Alt+R in both insert and default modes
for mode in insert default
    bind -M $mode alt-r toggle_tldr
end

function open
    xdg-open $argv >/dev/null 2>&1 &
    disown
end

# yazi
function f
    set -x YAZI_CWD $PWD

    set tmp (mktemp -t "yazi-cwd.XXXXXX")

    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ "$cwd" != "$PWD" ]; and test -d "$cwd"
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
