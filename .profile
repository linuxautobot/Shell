export PATH=$PATH:~/homebrew/bin
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export PATH=$PATH:/Users/a08447/Library/Python/2.7/bin
export NPMRC_AUTH_TOKEN_WEALTH=“8960c9c2-2ecb-4dff-a575-5651551c5606”
export ARTIFACTORY_PASSWORD=Artifactory-Build-User
export PATH=$PATH:/Users/a08447/homebrew/Cellar/apache-maven-3.6.1/bin
export PATH=$PATH:/Users/a08447/Library/Python/2.7/bin/aws
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTSIZE=1000000
export NVM_DIR="$HOME/.nvm"
export commonHist=$(history |  awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' |  grep -v "./" |  column -c3 -s " " -t |  sort -nr |  nl |  head -n10)



test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"


alias ...='cd ../../../'
alias ....='cd ../../../../'
alias .....='cd ../../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../..'
alias krug='networksetup -setairportnetwork en0 Krug'
alias wifioff='networksetup -setairportpower airport off'
alias wifion='networksetup -setairportpower airport on'
alias locationauto='networksetup -switchtolocation Automatic'
alias locationmgpru='networksetup -switchtolocation MGPru'
alias mgpru='locationmgpru && networksetup -setairportnetwork en0 MGPRU'
alias krug='locationauto &&  networksetup -setairportnetwork en0 Krug'
alias k=/usr/local/bin/kubectl
alias free=/Users/a08447/Project/learn/Python/free



changewifi(){
networksetup -setairportnetwork en0 $1
}
krugon(){
wifioff && sleep 5 && wifion && locationauto &&  krug 
}
mgpruon(){
wifioff && sleep 5 && wifion && locationmgpru && mgpru
}
macnetstat (){
    netstat -Watnlv | grep LISTEN | awk '{"ps -o comm= -p " $9 | getline procname;colred="\033[01;31m";colclr="\033[0m"; print colred "proto: " colclr $1 colred " | addr.port: " colclr $4 colred " | pid: " colclr $9 colred " | name: " colclr procname;  }' | column -t -s "|"
}
myip(){
if [ ${#@} -ne 0 ] && [ "$1" == "-h" ] || [ "$1" == "--help"  ]; then
  echo "$(tput setaf 2) Usage: country country-iso city json  port/8080"
  exit 0
else
  curl ifconfig.co/$1
fi
}
hist(){
 echo -e "$(tput setaf 3) $commonHist"
}



if [[ -e ~/.ssh/known_hosts ]]; then
  complete -W "$(echo `cat ~/.ssh/known_hosts | cut -f 1 -d ' ' | sed -e s/,.*//g | uniq | grep -v "\["`;)" ssh
fi

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
