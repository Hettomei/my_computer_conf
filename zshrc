##################
# TIPS AND TRICKS
# grepall finded_text file_extension
# on big command line press : CTRL-X-E (hold ctrl) and you can edit it on vim
#
# On os X, when press "space" to show preview, to convert file to text preview file :
# example to convert .scss file
# find . -name '*.scss' -exec SetFile -t TEXT {} \;
#
# convert wma into mp3
# for i in *.wma; do ffmpeg -i "$i" -ab 96k "${i%wma}mp3"; done
#
# Change every occurence into some files
# perl -i -p -e's/foo/bar/g' $(ack -l foo)
# ack -l foo <- display only file which contains foo
# Without previous ACK search :
# perl -i -p -e's/foo/bar/g' $(ack -f)
# or
# perl -i -p -e's/foo/bar/g' $(ack -f --ruby)
#
# do some operation on files
# find . -type f -name "*.erb" -exec git rm {} \;
#
# Rename multiple file : (here it removes .erb extension)
#
# for file in `find . -type f -name "*.haml"`
# do
# mv $file `echo $file | sed 's/\.erb//g'`
# done
#
# To sync my picture folder :
# rsync -av -e ssh Pictures hettomei@192.168.0.27:backup_mac
#
# To download a video from youtube and convert direct in mp3 (need youtube-dl + ffmpeg)
# youtube-dl "http://www.youtube.com/watch?v=4yRpysQxRxE&noredirect=1" --extract-audio --audio-format mp3

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#ZSH_THEME="aussiegeek"
#ZSH_THEME="rkj"
ZSH_THEME="alanpeabody"
#ZSH_THEME="random"
#theme de base :
#ZSH_THEME="robbyrussell"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="false"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

DISABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(colored-man)

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
#ne partage pas l'historique entre les session zsh. supprimer la ligne si je veux de nouveau les partager
setopt no_share_history

#export PAGER=''
export LESS='-R -X'

# Customize to your needs...
export VISUAL="vim"
export EDITOR="vim"

export PATH=$HOME/.rbenv/shims:/usr/local/sbin:$PATH
PATH=/usr/local/heroku/bin:$PATH
source "/usr/local/Cellar/rbenv/0.4.0/libexec/../completions/rbenv.zsh"
rbenv rehash 2>/dev/null
rbenv() {
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  shell)
    eval `rbenv "sh-$command" "$@"`;;
  *)
    command rbenv "$command" "$@";;
  esac
}

export JAVA_HOME=/Library/Java/Home
export GOPATH=$HOME/programmes/go
##### Android
PATH=$PATH:$HOME/programmes/android/sdk/tools
PATH=$PATH:$HOME/programmes/android/sdk/platform-tools

PATH=$PATH:$JAVA_HOME

###############################
#            ALIAS            #
# aka 'je suis une feignasse' #
###############################
#Alias pour aller directement vers ces paths
alias front='cd /Users/tim/BeMyBoat/bmb_front'
alias crm='cd /Users/tim/BeMyBoat/bemyboat/webapp'
alias tabarlus='cd /Users/tim/BeMyBoat/tabarlus'
alias apitabarlus='cd /Users/tim/BeMyBoat/tabarlus_api'
alias apitabarluss='cd /Users/tim/BeMyBoat/tabarlus_api/lib/tabarlus_api'
alias business='cd /Users/tim/BeMyBoat/bmb_business'
alias mmk='cd /Users/tim/BeMyBoat/mmk'
alias mmks='cd /Users/tim/BeMyBoat/mmk/lib/mmk'
alias sedna='cd /Users/tim/BeMyBoat/sedna'
alias sednas='cd /Users/tim/BeMyBoat/sedna/lib/sedna'
alias mister='cd /Users/tim/BeMyBoat/mister_booking'
alias misters='cd /Users/tim/BeMyBoat/mister_booking/lib/mister_b'
alias devinette='cd /Users/tim/programmes/Ruby/devinette'

# git
alias g='git'
alias pushmaster="git push origin master && git push upstream master"
alias pushprod="git push origin production && git push upstream production"
alias pushall="pushmaster && pushprod"
alias ggrep='git grep -nI'

#good website :  http://alias.sh/compact-colorized-git-log
# -n display line, -I ignore binary files
alias v='vim'
alias e='echo'
alias a='ack'
alias rmDS='find . -name ".DS_Store" -depth -exec rm {} \;'
#alias pause='ruby /Users/tim/programmes/Ruby/calcul_pause/start_pause.rb'
alias pause=job_break
#Copy current path to clipboard. #works on mac OS X maybe not linux
alias pwdc='echo -n `pwd` | pbcopy; echo "copy to clipboard: `pbpaste`"'
#because bc as the "scale" init to 0 if run without argument
alias bc='bc -l -q'

##
# find text 'test' il all '.txt' file recursively from current dir
# maybe ack do this like "cd to/the/dir ; ack --text test"
# example: grepall test txt
function grepall() {
  echo "find text '$1'";
  echo "In files << $2 >>";
  grep -ni "$1" **/*.$2
}

function sms() {
  #$1 -> the phone number
  #$2 -> the message
  #$2 -> optional, could be "edit"
  adb shell am start -a android.intent.action.SENDTO -d sms:$1 --es sms_body "$2" --ez exit_on_sent true

  if [[ $3 = "edit" ]];then
    echo "edit mode, check your phone"
    # commands....
  else
    echo "send mode"
    sleep 1
    adb shell input keyevent 22
    sleep 1
    adb shell input keyevent 66
    echo "sent"
  fi
}

function editsms() {
  #$1 -> the phone number
  #$2 -> the message
  sms $1 $2 edit
}

function smsangie() {
  #$1 -> the messages
  #$2 -> optional, could be "edit"
  sms +33652013403 $1 $2
}

#################
# Special Rails #
#################

#obligé sinon il ne comprend pas rake de rails......
#alias rake='noglob rake'
#need a file 'Procfile'
alias fsa='foreman start -c mysql=1,mongodb=1,redis=1,db=1,beanstalkd=1,backburner=1,web=0,sidekiq=1'
alias fsas='foreman start -c mysql=1,mongodb=1,redis=1,db=1,beanstalkd=1,backburner=1,web=0,sidekiq=0'
alias fsw='foreman start web'
alias be='noglob bundle exec'
alias ber='noglob bundle exec rspec'
alias sp='spin push'

alias httpserv="python -m SimpleHTTPServer"
