set -U fish_key_bindings fish_vi_key_bindings
set -U fish_prompt_pwd_dir_length 2
set -U fish_fzf_path (dirname (dirname (which fzf)))

set fish_color_comment brgrey

set -eU fish_greeting
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
