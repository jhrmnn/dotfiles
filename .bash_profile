maybe_source_bashrc () {
    if [[ "$-" =~ "i" ]]; then
        [ -s ~/.bashrc ] && . ~/.bashrc;
    fi
}

if [ -n "$PROFILE_SOURCED" ]; then
    maybe_source_bashrc
    return
fi

[ -s ~/.profile ] && . ~/.profile
maybe_source_bashrc
