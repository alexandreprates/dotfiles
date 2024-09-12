# Theme by ajfprates at gmail dot com

local _current_dir='${PWD/#$HOME/~}'
local _git_info='$(git_prompt_info)'

PROMPT="%{$FG[040]%}%n%{$reset_color%} %{$FG[239]%}at%{$reset_color%} %{$FG[033]%}$(hostname)%{$reset_color%} %{$FG[239]%}in%{$reset_color%} %{$terminfo[bold]$FG[226]%}${_current_dir} %{$reset_color%}${_git_info} $reset_color%}
>: "

#ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}  %{$fg[255]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$FG[202]%}  "
#ZSH_THEME_GIT_PROMPT_CLEAN="%{$FG[040]%}  "
