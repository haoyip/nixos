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

# General abbr
abbr -a d cdh
abbr -a e vi
abbr -a f 'nix flake'
abbr -a gg lazygit
abbr -a j cd # zoxide
abbr -a ji cdi # zoxide
abbr -a l ls
abbr -a la 'ls -la'
abbr -a m 'zellij -s $(tr -dc a-z0-9 </dev/urandom | head -c 3 ; echo "")'
abbr -a n nix
abbr -a o xdg-open
abbr -a sc systemctl
abbr -a scs 'systemctl status'
abbr -a ssh 'TERM=xterm-256color ssh'
abbr -a t tldr
abbr -a tf terraform

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

# Docker
abbr -a dk docker
abbr -a dc 'docker compose'
abbr -a dps 'docker ps'
abbr -a dl 'docker logs'

# If in alacritty, start zellij
if test $TERM = alacritty && not set -q ZELLIJ
    zellij -s (tr -dc a-z0-9 </dev/urandom | head -c 3 ; echo "")

    kill $fish_pid
end
