set -U fish_key_bindings fish_vi_key_bindings
set -U fish_prompt_pwd_dir_length 2
set -U fish_fzf_path (dirname (dirname (which fzf)))

set -eU fish_greeting

set -U fish_color_normal normal
set -U fish_color_error -o red
set -U fish_color_command -o brwhite
set -U fish_color_param blue
set -U fish_color_escape magenta
set -U fish_color_end -o brwhite
set -U fish_color_quote green
set -U fish_color_operator yellow
set -U fish_color_autosuggestion bryellow
set -U fish_color_comment brgrey
set -U fish_color_redirection magenta
set -U fish_color_history_current green
set -U fish_color_match -o brmagenta
set -U fish_color_search_match --background=bryellow
set -U fish_color_selection --background=bryellow
set -U fish_color_valid_path --underline

set -U fish_pager_color_completion normal
set -U fish_pager_color_description bryellow
set -U fish_pager_color_prefix blue
set -U fish_pager_color_progress cyan

set -eU fish_user_abbreviations
abbr vi vim
abbr ll ls -l
abbr la ls -la
abbr lt ls -lrt
abbr lta ls -lrta
abbr pty ptpython
abbr ipty ptipython
abbr jupy jupyter notebook
abbr xo xonsh
abbr gitk gitk --all
abbr makeup make -C ..
abbr del trash

if [ -f ~/.config/fish/local.init.fish ]
    source ~/.config/fish/local.init.fish
end
