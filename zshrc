export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="lost"

ZSH_CUSTOM=$HOME/.dotfiles/oh_my_zsh

plugins=(git docker docker-compose heroku)


# User configuration
source $ZSH/oh-my-zsh.sh
source $HOME/.dotfiles/scripts/toolbox.sh

# Load go2dir
[[ -s "$HOME/.go2dir/go2dir.sh" ]] && source "$HOME/.go2dir/go2dir.sh"
