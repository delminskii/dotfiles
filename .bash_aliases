alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -A'
alias l='ls -CF'
alias xup='xrdb -merge $HOME/.Xresources'
alias tmux='tmux -2'
alias tls='tmux ls'
alias tatt='tmux attach'
alias tkillall='tmux kill-server'
alias zonasin='cd $HOME/python_proj/test/cableCo/zonASINhunter'
alias newegg='cd $HOME/python_proj/test/cableCo/newegg3'
alias flasksandbox='cd $HOME/sandbox/flask_PY3'
alias vim='TERM=tmux-256color nvim.appimage'
alias ivm=vim
alias nvim=vim
alias vimrc='vim $HOME/.vimrc'
alias tpp='vim /tmp/$(cat /dev/urandom | env LC_CTYPE=C tr -cd 'a-f0-9' | head -c 32).py'
alias bashrc='vim $HOME/.bashrc'
alias wgetrc='vim $HOME/.wgetrc'
alias conkyrc='vim $HOME/.conkyrc'
alias muttrc='vim $HOME/.muttrc'
alias sshconfig='vim $HOME/.ssh/config'
alias xresources='vim $HOME/.Xresources'
alias tmuxconfig='vim $HOME/.tmux.conf'
alias podcast='mpv --profile=podcast'
alias remote='ssh vultrserver'
alias remote3='ssh py3_vultrserver'
alias downloads='cd $HOME/downloads/ && ll ./'
alias tmp='cd /tmp'
alias aliases='vim $HOME/.bash_aliases'
alias make_go_dirs='mkdir src pkg bin cmd'
alias python3='/usr/local/bin/python3.7'
alias py3=python3
alias ipython3='$HOME/.local/bin/ipython3'
alias docker_remove_containers_exited='docker rm -v $(docker ps -aq -f status=exited)'
alias vpnstatus='$VPNPYTHON -m protonvpn_cli status'
alias vpnconnect='sudo $VPNPYTHON -m protonvpn_cli connect --fastest && vpnstatus'
alias vpnrandomconnect='sudo $VPNPYTHON -m protonvpn_cli connect --random && vpnstatus'
alias vpndisconnect='sudo $VPNPYTHON -m protonvpn_cli disconnect && vpnstatus'
alias watchvpn='watch -n5 $VPNPYTHON -m protonvpn_cli status'
