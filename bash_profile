# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

export PATH=$PATH:$HOME/bin:$HOME/Documents/go/bin:/opt/gradle/gradle-5.1.1/bin

month=$(date +"%B")
week_num=$((($(date +"%-d")-1)/7+1))
export DISPLAY=:0 ;
IP="$(echo $SSH_CONNECTION | cut -d " " -f 1)"
HOSTNAME=$(hostname)
NOW=$(date +"%e %b %Y, %a %r")
#host="$(grep -B1 -w $IP $HOME/.ssh/config |awk '{print $2}'|head -1)"
host="$(awk -v ip=$IP '$NF==ip {print a}{a=$NF}' $HOME/.ssh/config)"
if [ -z "$host" ];then
	host="User"
fi	
FINAL=$(echo ''${host^}' from '$IP' logged into '$HOSTNAME' on '$NOW'.')
[[ ! -d /home/rakesh/accesslogs/$month ]] && mkdir /home/rakesh/accesslogs/$month
echo $FINAL >> /home/rakesh/accesslogs/${month}/week_$week_num
notify-send -t 5000 -i /usr/share/yelp/icons/yelp-icon-important.png "SSH-ALERT" "$FINAL" 
export GCONFTOOL=/usr/bin/gconftool-2
