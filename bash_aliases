alias cls='clear'
alias colors='xfce4-terminal --color-table'
alias d='dirs'
alias df='df -h --total'
alias dirs='dirs -p -v'
alias fknbt='sudo modprobe -r btusb; sudo modprobe btusb'
alias fknwifi='sudo service network-manager restart'
alias glo='git log --oneline -n 5'
alias has="dpkg --get-selections | grep -v deinstall | awk '{ print \$1 }' | grep -i"
alias hidebar='xdo above -t $(xdo id -n root) $(xdo id -a bar)'
alias l='ls -CF'
alias la='ls -Al'
alias linst='apt list --installed'
alias ll='ls -AlF'
alias ls='ls -l --color=auto'
alias od='popd'
alias pd='pushd'
alias pls='sudo $(fc -ln -1)'
alias py='python3'
alias todo='grep -n TODO: ./*'

