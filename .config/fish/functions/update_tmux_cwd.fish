function update_tmux_cwd --on-variable PWD
    set -q TMUX; and printf '\ePtmux\e;\e\e]7;file://%s%s\a\e\\' (hostname) (pwd | __fish_urlencode)
end
