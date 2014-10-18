function my_fish_vi_key_bindings
    fish_vi_key_bindings
    bind \cc kill-whole-line
    bind -M insert \cc kill-whole-line
    bind -M insert -m default \e backward-char
end

