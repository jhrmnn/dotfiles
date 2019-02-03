function fish_right_prompt
    if [ -n "$PROMPT_RIGHT" ]
        echo -ns (set_color -o magenta) " $PROMPT_RIGHT" (set_color normal)
    end
end

