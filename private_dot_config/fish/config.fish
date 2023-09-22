## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
## Export variable need for qt-theme
if type qtile >>/dev/null 2>&1
    set -x QT_QPA_PLATFORMTHEME qt5ct
end

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
# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons' # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons' # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.="exa -a | egrep '^\.'" # show only dotfiles
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
set -gx TERMINAL alacritty
abbr -a -- rr ranger
abbr -a -- gits git status
abbr -a -- alac vim ~/.alacritty.yml
abbr -a -- cm chezmoi
abbr -a -- relof source ~/.config/fish/config.fish
alias upd="yes | yay -Syu"
alias upd-ocaml="opam update && opam upgrade -y"
alias upd-rust="cargo install-update a"
# alias upd-haskell="cabal update"
alias upd-nix="nix-channel --update; nix-env --install --attr nixpkgs.nix nixpkgs.cacert"
abbr -a --position anywhere upd-all "upd && upd-ocaml && upd-rust && upd-nix"
#
#
set -x PATH  ~/.cargo/bin/ ~/.opam/default/bin ~/.nix-profile/bin /nix/var/nix/profiles/default/bin ~/.nim /usr/lib/jvm/java-17-graalvm/bin  ~/.cabal/bin ~/.ghcup/bin /opt/ibm/ILOG/CPLEX_Studio201/cplex/bin/x86-64_linux/ ~/.pyenv/bin ~/.opam/default/bin ~/.local/bin /usr/local/bin /usr/bin /usr/local/sbin /usr/lib/jvm/default/bin /usr/bin/site_perl /usr/bin/vendor_perl /usr/bin/core_perl 


#
#
# if test -f ~/.local/share/chezmoi
#     chezmoi re-add
# pyenv configuration
if test -d ~/.pyenv
    pyenv init - | source
end

# opam configuration
if test -d ~/.opam
    eval (opam env)
    source /home/fxdx/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
end


