# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

COLOR_YELLOW="\[\033[33m\]"
COLOR_RESET="\[\033[0m\]"

# Function to dynamically set the virtual environment prompt
set_venv_prompt() {
    if [[ -n $VIRTUAL_ENV ]]; then
        local venv_name=${VIRTUAL_ENV##*/}
        VENVPROMPT="${COLOR_YELLOW}${venv_name}${COLOR_RESET} "
    else
        VENVPROMPT=""
    fi
}
    
# Function to dynamically set the job count prompt
set_job_prompt() {
    local jobcount=$(jobs -p | wc -l)
    if [ "$jobcount" -gt 0 ]; then
        JOBPROMPT=" [$jobcount]"
    else
        JOBPROMPT=""
    fi
}

# Enable Git prompt features
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_DESCRIBE_STYLE='default' # options: contains | branch | describe | default
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUPSTREAM='auto'

PROMPT_COMMAND='set_venv_prompt; set_job_prompt; __git_ps1 "${VENVPROMPT}\u@\h:\w" "${JOBPROMPT}\n${COLOR_YELLOW}→  ${COLOR_RESET}"'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias ls='ls --color=auto'
    alias diff='diff --color'
fi

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
          NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)$"
    command nnn -deHA "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi

if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

export FZF_DEFAULT_OPTS=" \
--color=bg+:#2d333b,bg:#282c34,spinner:#6cb6ff,hl:#ff938a \
--color=fg:#bbc2cf,header:#ff938a,info:#b083f0,pointer:#6cb6ff \
--color=marker:#539bf5,fg+:#adbac7,prompt:#b083f0,hl+:#ff938a \
--color=selected-bg:#2d333b \
--color=border:#2d333b,label:#adbac7 \
--multi \
--tmux center,100% \
--layout=reverse"

export FZF_ALT_C_COMMAND=

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

BLK="03" CHR="03" DIR="04" EXE="02" REG="07" HARDLINK="05" SYMLINK="05" MISSING="08" ORPHAN="01" FIFO="06" SOCK="03" UNKNOWN="01"
export NNN_COLORS="#04020301;4231"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$UNKNOWN"


if [[ "$XDG_CURRENT_DESKTOP" =~ [Gg][Nn][Oo][Mm][Ee] ]]; then
    gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 17
    gsettings set org.gnome.desktop.peripherals.keyboard delay 200
fi

if command -v lazygit >/dev/null 2>&1; then
    alias lg=lazygit
fi

if command -v hx >/dev/null 2>&1; then
    export EDITOR=hx
    export VISUAL=hx
fi

if command -v jj >/dev/null 2>&1; then
    source <(COMPLETE=bash jj)
fi

if command -v direnv >/dev/null 2>&1; then
    eval "$(direnv hook bash)"
fi
