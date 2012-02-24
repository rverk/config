###############
### ALIASES ###
###############

alias cp='cp -iv'			    # cp askes for overwrite and is verbose
alias mv='mv -iv'

# Tails for common logfiles
alias tf='tail -50f /var/log/iptables.log'
alias tm='tail -50f /var/log/messages.log'
alias ts='tail -50f /var/log/auth.log'

# Move around
alias back='cd $OLDPWD'			# back to previous dir
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

## Keeping things organized
alias ls='ls --color=auto'
alias ll='ls -ahlF'
alias la='ls -A'
alias cp='cp -iv'
alias mv='mv -i'
alias mkdir='mkdir -p -v'
alias df='df -h'
alias du='du -h -c'
alias reload='source ~/.bashrc'
alias biggest='BLOCKSIZE=1048576; du -x | sort -nr | head -10'

## Dir shortcuts
alias home='cd ~/'
alias documents='cd ~/Documents'
alias downloads='cd ~/Downloads'
alias dev='cd ~/dev'

## vim
alias g='gvim --remote-silent'      # Keep only one gvim session
alias vi='vim'

## Apt-get
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias search='apt-cache search'

# Truecrypt
alias utrue='sudo truecrypt -d'

# Networking
alias openports='netstat -nape --inet'
alias opennet='lsof -i'

# ps shorts
alias pg='ps aux | grep'  #requires an argument

# Hadoop shorts
alias fs='hadoop fs'
alias hls='fs -ls'

# UnitTesting
alias punit='python -m unittest discover -v'     #search for and run python unittests

# Diary shorts
alias prodia='vim ~/dev/diary/prof.txt'
