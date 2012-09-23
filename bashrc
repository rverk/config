# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Set appropriate ls alias
case $(uname -s) in
        Darwin|FreeBSD)
                alias ls="ls -hFG"
        ;;
        Linux)
                alias ls="ls --color=always -hF"
        ;;
        NetBSD|OpenBSD)
                alias ls="ls -hF"
        ;;
esac

 
# Set git autocompletion and PS1 integration
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    . /usr/local/git/contrib/completion/git-completion.bash
fi
GIT_PS1_SHOWDIRTYSTATE=true

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# set git colorprompt
PS1='\[\033[01;32m\]\u@\h:\[\033[01;34m\]\w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\]\$\[\033[00m\] '


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Include additional files. Bash private for machine specific settings
[ -f ~/.bash_functions ] && . ~/.bash_functions
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_private ] && . ~/.bash_private

# Java Home
export JAVA_HOME=/usr/lib/jvm/default-java
