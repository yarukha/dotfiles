set -g fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
fish_add_path /usr/bin/
fish_add_path /bin/
fish_add_path /usr/local/bin/
fish_add_path ~/.custom_bin/

switch (uname)
    case Darwin
       # do things for macOS
      fish_add_path /opt/homebrew/bin/
      fish_add_path /Users/fxdx/Library/Application
    case Linux
      # do things for Linux
      fish_add_path ~/.local/bin
    case '*'
end

# Hide welcome message

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
## Export variable need for qt-theme
# if type qtile >>/dev/null 2>&1
    # set -x QT_QPA_PLATFORMTHEME qt5ct
# end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low


## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
    source ~/.fish_profile
end

## Starship prompt
if status --is-interactive
    starship init fish | source
end


## Advanced command-not-found hook
# if test -d /usr/share/doc/find-the-command/
#     source /usr/share/doc/find-the-command/ftc.fish
# end


## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
    switch (commandline -t)
        case "!"
            commandline -t $history[1]
            commandline -f repaint
        case "*"
            commandline -i !
    end
end

function __history_previous_command_arguments
    switch (commandline -t)
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ]
    bind -Minsert ! __history_previous_command
    bind -Minsert '$' __history_previous_command_arguments
else
    bind ! __history_previous_command
    bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

# Copy DIR1 DIR2
function copy
    set count (count $argv | tr -d \n)
    if test "$count" = 2; and test -d "$argv[1]"
        set from (echo $argv[1] | trim-right /)
        set to (echo $argv[2])
        command cp -r $from $to
    else
        command cp $argv
    end
end

## Useful aliases
# Replace ls with eza
alias ls='eza -al --color=always --group-directories-first --icons' # preferred listing
alias la='eza -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='eza -l --color=always --group-directories-first --icons' # long format
alias lt='eza -aT --color=always --group-directories-first --icons' # tree listing
alias l.="eza -a | egrep '^\.'" # show only dotfiles
alias ip="ip -color"

# Replace some more things with better alternatives
alias cat='bat --style header --style snip --style changes --style header'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru'

# Common use
alias grubup="sudo update-grub"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias tarnow='tar -acf '
alias untar='tar -xvf '
alias wget='wget -c '
alias rmpkg="sudo pacman -Rdd"
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias hw='hwinfo --short' # Hardware Info
alias big="expac -H M '%m\t%n' | sort -h | nl" # Sort installed packages according to size in MB
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l' # List amount of -git packages

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"

set -gx EDITOR nvim
set -gx VISUAL nvim
switch (uname)
  case Darwin 
    set -gx TERMINAL iterm2
  case "*"
    set -gx TERMINAL alacritty
end

abbr -a -- rr ranger
abbr -a -- gits git status
abbr -a -- alac $EDITOR ~/.alacritty.toml
abbr -a -- cm chezmoi
abbr -a -- fishc $EDITOR ~/.config/fish/config.fish
abbr -a -- relof source ~/.config/fish/config.fish
abbr -a -- lspc $EDITOR ~/.config/nvim/lua/custom/configs/lspconfig.lua
abbr -a -- fmtc $EDITOR ~/.config/nvim/lua/custom/configs/null-ls.lua
abbr -a -- plugc $EDITOR ~/.config/nvim/lua/custom/plugins.lua
abbr -a -- tmuxc $EDITOR ~/.tmux.conf

# alias upd="yes | yay -Syu"
alias upd-ocaml="opam update && opam upgrade -y"
alias upd-rust="cargo install-update -a"
# alias upd-haskell="cabal update"
alias upd-nix="nix-env --install --attr nixpkgs.nix nixpkgs.cacert"
# abbr -a --position anywhere upd-all "upd && upd-ocaml && upd-rust && upd-nix"

abbr -a vi nvim 
abbr -a vim nvim

if test -f ~/.local/share/chezmoi
    chezmoi re-add
end

# pyenv configuration
if test -d ~/.pyenv
    fish_add_path ~/.pyenv/bin/
    pyenv init - | source
end

#haskell config
if test -d ~/.ghcup
  fish_add_path ~/.ghcup/bin/
  fish_add_path ~/.cabal/bin/
  set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME 
end

#rust config
if test -d ~/.cargo 
  fish_add_path ~/.cargo/bin/
end

# ocaml config
if test -d ~/.opam
    eval (opam env)
    source /home/fxdx/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
end

#scala config 
switch (uname)
  case Darwin
    if test -d "~/Library/Application Support/Coursier"
      fish_add_path /Users/fxdx/Library/Application Support/Coursier/bin
    end 
  case Linux 
    if test -d ~/.local/share/coursier
      fish_add_path ~/.local/share/coursier/bin
    end 
end 


switch (uname)
  case Darwin
    eval "$(/opt/homebrew/bin/brew shellenv)"
  case "*"
end


