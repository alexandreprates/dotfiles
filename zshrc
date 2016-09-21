export ZSH=/home/aprates/.oh-my-zsh

ZSH_THEME="lost"

plugins=(git archlinux docker docker-compose ruby rbenv)

export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin"

# User configuration
source $HOME/.dotfiles/scripts/toolbox.sh
source $ZSH/oh-my-zsh.sh

# Load rbenv
PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"


# Load go2dir
[[ -s "/home/aprates/.go2dir/go2dir.sh" ]] && source "/home/aprates/.go2dir/go2dir.sh"
