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
HISTSIZE=100000
HISTFILESIZE=100000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# command is executed before 
prompt_command () {
    local prompt="\[\033[0;34m\][\w]\[\033[00m\]\n\$ "
    local virtualenv=

    if [[ -n $VIRTUAL_ENV ]]; then
        virtualenv="($(basename $VIRTUAL_ENV))"
    fi

    # enable posh-git prompt if available
    if [ -f ~/notmine/posh-git-sh/git-prompt.sh ]; then
        source ~/notmine/posh-git-sh/git-prompt.sh
        # __post_git_ps1 is a function that sets the PS1 variable
        __posh_git_ps1 "$virtualenv" "$prompt"
    else
        PS1=$prompt
    fi
}

# PROMPT_COMMAND is a command that runs before the prompt displays
PROMPT_COMMAND='prompt_command'

# If this is an xterm set the title to user@host:dir
# TODO this is cancelled out by the prompt_command above
# however, keeping this as it might affect TTYs
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -lF --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

day () {
    sed -e 's/set background=dark/set background=light/g' -i ~/.vimrc

    if [ -f ~/.config/xfce4/terminal/terminalrc ]; then
        sed -e 's/ColorCursor=#.*$/ColorCursor=#9393a1a1a1a1/g' -i ~/.config/xfce4/terminal/terminalrc
        sed -e 's/ColorForeground=#.*$/ColorForeground=#00002B2B3636/g' -i ~/.config/xfce4/terminal/terminalrc
        sed -e 's/ColorBackground=#.*$/ColorBackground=#fdfdf6f6e3e3/g' -i ~/.config/xfce4/terminal/terminalrc
    fi
}

night () {
    sed -e 's/set background=light/set background=dark/g' -i ~/.vimrc

    if [ -f ~/.config/xfce4/terminal/terminalrc ]; then
        sed -e 's/ColorCursor=#.*$/ColorCursor=#0f0f49499999/g' -i ~/.config/xfce4/terminal/terminalrc
        sed -e 's/ColorForeground=#.*$/ColorForeground=#838394949696/g' -i ~/.config/xfce4/terminal/terminalrc
        sed -e 's/ColorBackground=#.*$/ColorBackground=#00002b2b3636/g' -i ~/.config/xfce4/terminal/terminalrc
    fi
}

where () {
    grep -n $1 ./*.*
}

igrep () {
    local pids=$(pgrep -fi $1)
    if [[ -z $pids ]]; then
        echo "No processes matching '$1' found"
    else
        ps -o pid,ppid,user,tty,cmd -p $pids
    fi
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -e "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Workaround for 256 colors in xfce4-terminal, this fixes colors in tmux
if [ "$COLORTERM" == "xfce4-terminal" ]; then
    export TERM=xterm-256color
fi

# Enable vi mode in bash
set -o vi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
