set -g fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT 1
fish_add_path /usr/bin/
fish_add_path /bin/
fish_add_path /usr/local/bin/
fish_add_path ~/.custom_bin/
fish_add_path /opt/local/bin

switch (uname)
    case Darwin
       # do things for macOS
      fish_add_path /opt/homebrew/bin/
      fish_add_path ~/Library/Application
    case Linux
      # do things for Linux
      fish_add_path ~/.local/bin
    case '*'
end

# Hide welcome message

set -x MANPAGER "sh -c 'bat -l man -p'"
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
    enable_transience
    atuin init fish | source
end


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
alias ls='eza -l --color=always --group-directories-first --icons' # preferred listing
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

# custom shortcuts

abbr -a -- rr ranger
abbr -a -- gits git status
abbr -a -- alac $EDITOR ~/.alacritty.toml
abbr -a -- wezc $EDITOR ~/.config/wezterm/wezterm.lua
abbr -a -- ghostc $EDITOR ~/.config/ghostty/config
abbr -a -- cm chezmoi
abbr -a -- fishc $EDITOR ~/.config/fish/config.fish
abbr -a -- gitc $EDITOR ~/.gitconfig
abbr -a -- relof source ~/.config/fish/config.fish
abbr -a -- lspc $EDITOR ~/.config/nvim/lua/configs/lspconfig.lua
abbr -a -- fmtc $EDITOR ~/.config/nvim/lua/configs/conform.lua
abbr -a -- plugc $EDITOR ~/.config/nvim/lua/plugins.lua
abbr -a -- tmuxc $EDITOR ~/.tmux.conf
abbr -a -- yazic $EDITOR ~/.config/yazi/yazi.toml


#yazi cwd change
function yy
	set tmp (mktemp -t "yazi-cwd.XXXXXX")
	yazi $argv --cwd-file="$tmp"
	if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
		builtin cd -- "$cwd"
	end
	rm -f -- "$tmp"
end





# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd
    builtin pwd -L
end

# A copy of fish's internal cd function. This makes it possible to use
# `alias cd=z` without causing an infinite loop.
if ! builtin functions --query __zoxide_cd_internal
    if builtin functions --query cd
        builtin functions --copy cd __zoxide_cd_internal
    else
        alias __zoxide_cd_internal='builtin cd'
    end
end

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd
    __zoxide_cd_internal $argv
end

# =============================================================================
#
# Hook configuration for zoxide.
#

# Initialize hook to add new entries to the database.
function __zoxide_hook --on-variable PWD
    test -z "$fish_private_mode"
    and command zoxide add -- (__zoxide_pwd)
end

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

if test -z $__zoxide_z_prefix
    set __zoxide_z_prefix 'z!'
end
set __zoxide_z_prefix_regex ^(string escape --style=regex $__zoxide_z_prefix)

# Jump to a directory using only keywords.
function __zoxide_z
    set -l argc (count $argv)
    if test $argc -eq 0
        __zoxide_cd $HOME
    else if test "$argv" = -
        __zoxide_cd -
    else if test $argc -eq 1 -a -d $argv[1]
        __zoxide_cd $argv[1]
    else if set -l result (string replace --regex $__zoxide_z_prefix_regex '' $argv[-1]); and test -n $result
        __zoxide_cd $result
    else
        set -l result (command zoxide query --exclude (__zoxide_pwd) -- $argv)
        and __zoxide_cd $result
    end
end

# Completions.
function __zoxide_z_complete
    set -l tokens (commandline --current-process --tokenize)
    set -l curr_tokens (commandline --cut-at-cursor --current-process --tokenize)

    if test (count $tokens) -le 2 -a (count $curr_tokens) -eq 1
        # If there are < 2 arguments, use `cd` completions.
        complete --do-complete "'' "(commandline --cut-at-cursor --current-token) | string match --regex '.*/$'
    else if test (count $tokens) -eq (count $curr_tokens); and ! string match --quiet --regex $__zoxide_z_prefix_regex. $tokens[-1]
        # If the last argument is empty and the one before doesn't start with
        # $__zoxide_z_prefix, use interactive selection.
        set -l query $tokens[2..-1]
        set -l result (zoxide query --exclude (__zoxide_pwd) --interactive -- $query)
        and echo $__zoxide_z_prefix$result
        commandline --function repaint
    end
end
complete --command __zoxide_z --no-files --arguments '(__zoxide_z_complete)'


set GO_TASK_PROGNAME task

function __task_get_tasks --description "Prints all available tasks with their description"
  # Read the list of tasks (and potential errors)
  $GO_TASK_PROGNAME --list-all 2>&1 | read -lz rawOutput

  # Return on non-zero exit code (for cases when there is no Taskfile found or etc.)
  if test $status -ne 0
    return
  end

  # Grab names and descriptions (if any) of the tasks
  set -l output (echo $rawOutput | sed -e '1d; s/\* \(.*\):\s*\(.*\)\s*(\(aliases.*\))/\1\t\2\t\3/' -e 's/\* \(.*\):\s*\(.*\)/\1\t\2/'| string split0)
  if test $output
    echo $output
  end
end

complete -c $GO_TASK_PROGNAME -d 'Runs the specified task(s). Falls back to the "default" task if no task name was specified, or lists all tasks if an unknown task name was
specified.' -xa "(__task_get_tasks)"

complete -c $GO_TASK_PROGNAME -s c -l color     -d 'colored output (default true)'
complete -c $GO_TASK_PROGNAME -s d -l dir       -d 'sets directory of execution'
complete -c $GO_TASK_PROGNAME      -l dry       -d 'compiles and prints tasks in the order that they would be run, without executing them'
complete -c $GO_TASK_PROGNAME -s f -l force     -d 'forces execution even when the task is up-to-date'
complete -c $GO_TASK_PROGNAME -s h -l help      -d 'shows Task usage'
complete -c $GO_TASK_PROGNAME -s i -l init      -d 'creates a new Taskfile.yml in the current folder'
complete -c $GO_TASK_PROGNAME -s l -l list      -d 'lists tasks with description of current Taskfile'
complete -c $GO_TASK_PROGNAME -s o -l output    -d 'sets output style: [interleaved|group|prefixed]' -xa "interleaved group prefixed"
complete -c $GO_TASK_PROGNAME -s p -l parallel  -d 'executes tasks provided on command line in parallel'
complete -c $GO_TASK_PROGNAME -s s -l silent    -d 'disables echoing'
complete -c $GO_TASK_PROGNAME      -l status    -d 'exits with non-zero exit code if any of the given tasks is not up-to-date'
complete -c $GO_TASK_PROGNAME      -l summary   -d 'show summary about a task'
complete -c $GO_TASK_PROGNAME -s t -l taskfile  -d 'choose which Taskfile to run. Defaults to "Taskfile.yml"'
complete -c $GO_TASK_PROGNAME -s v -l verbose   -d 'enables verbose mode'
complete -c $GO_TASK_PROGNAME      -l version   -d 'show Task version'
complete -c $GO_TASK_PROGNAME -s w -l watch     -d 'enables watch of the given task'

# Jump to a directory using interactive search.
function __zoxide_zi
    set -l result (command zoxide query --interactive -- $argv)
    and __zoxide_cd $result
end

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

abbr --erase cd &>/dev/null
alias cd=__zoxide_z

abbr --erase cdi &>/dev/null
alias cdi=__zoxide_zi


abbr -a vi nvim 
abbr -a vim nvim

#uv config
#uv generate-shell-completion fish | source
#uvx --generate-shell-completion fish | source

#pyenv config 
if test -d ~/.pyenv/ 
  fish_add_path ~/.pyenv/bin/
  pyenv init - fish | source
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
    source ~/.opam/opam-init/init.fish >/dev/null 2>/dev/null; or true
end

#scala config 
switch (uname)
  case Darwin
    # if test -d "~/Library/Application Support/Coursier"
    #   fish_add_path ~/Library/Application Support/Coursier/bin
    # end 
  case Linux 
    if test -d ~/.local/share/coursier
      fish_add_path ~/.local/share/coursier/bin
    end 
end 

#dotnet config 
switch (uname)
  case Darwin 
    if test -d ~/.dotnet/
      fish_add_path ~/.dotnet/tools/
    end 
end

switch (uname)
  case Darwin
    if test -d /opt/homebrew/bin/
      eval (/opt/homebrew/bin/brew shellenv)
    end
  case "*"
end

fzf --fish | source

chezmoi update 
