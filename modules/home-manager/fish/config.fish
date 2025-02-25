function fish_greeting
end

fish_vi_key_bindings

set fish_cursor_default block
set fish_cursor_insert line
set fish_cursor_replace_one underscore
set fish_cursor_visual block

starship init fish | source
zoxide init --cmd cd fish | source

alias ls 'eza -l1'
alias cat bat
alias grep rg
alias jq jaq
alias cl wl-copy
alias http xh
alias note "vi '/data/8tb_1/HY/Library/Notes/' -c 'cd /data/8tb_1/HY/Library/Notes/'"
alias sshx "TERM=xterm-256color ssh"

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
abbr -a o xdg-open
abbr -a sc systemctl
abbr -a scs 'systemctl status'
abbr -a t tldr
abbr -a tf terraform
abbr -a f xdg-open . # open file explorer here

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

# If in alacritty and not in ssh, start zellij
if test $TERM = alacritty && test ! $SSH_CLIENT && not set -q ZELLIJ
    zellij -s (tr -dc a-z0-9 </dev/urandom | head -c 3 ; echo "")

    kill $fish_pid
end
