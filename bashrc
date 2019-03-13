# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
fi
#printf "\e[?2004l" # remove trailing 0~ or ~1 while copy paste
PATH=$PATH:$HOME/bin:$HOME/Documents/go/bin
export GOPATH=$HOME/Documents/go
# User specific aliases and functions
export HISTTIMEFORMAT="%d/%m/%y %T "
export HISTIGNORE="ls*:history*"	# avoid storing given command to history
#export HISTIGNORE="ls*:ssh*:history*"	# avoid storing given command to history
export PROMPT_COMMAND='history -a'	#record each line of history as you issue, to avoid losing history, when session crashes
alias lsdir='ls -ld */'
shopt -s cdspell # autocorrection while switching directory
shopt -s histappend # append to history file, don't overwrite it
#export SSH_SOURCE_IP=$(echo $SSH_CONNECTION|cut -d' ' -f 1)
#export VIM_COLOR_SCHEME="alduin"  
#if [ "$SSH_SOURCE_IP" == "192.168.20.112" ]; then
#	      export VIM_COLOR_SCHEME="torte"
#      fi
#/usr/local/bin/dynmotd

#function log2syslog
#{
#	declare COMMAND
##	COMMAND=$(fc -ln -0)
#	/usr/bin/stdbuf -oL logger -p local1.notice -t bash -i -- "CONTROL -> ${SSH_CLIENT/ */}: ${USER}:${SUDO_USER}: $(fc -nl -1)"
#}
#trap log2syslog DEBUG
IP=`echo $SSH_CLIENT | awk '{print $1}'`
function log2syslog
{
       declare COMMAND
       COMMAND=$(fc -ln -0)
       logger -p local1.notice -t bash  -- "SESSION: ${IP}-${USER}:${SUDO_USER}:${COMMAND}"
}
trap log2syslog DEBUG

#
#function log2syslog
#{
#       declare COMMAND
#       COMMAND=$(fc -ln -0)
#       logger -p local1.notice -t bash  -- "${SSH_CLIENT/ */}: ${USER}:${SUDO_USER}: ${COMMAND}" 
#}
#trap log2syslog DEBUG
#
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash
#
