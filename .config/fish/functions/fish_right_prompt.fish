function fish_right_prompt
    if [ -n "$PROMPT_RIGHT" ]
        echo -ns (set_color -o magenta) " $PROMPT_RIGHT"
    end
end

