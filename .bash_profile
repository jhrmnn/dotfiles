run_bashrc () { [[ "$-" =~ "i" ]] && [[ -s ~/.bashrc ]] && . ~/.bashrc; }

[[ -n "$PROFILE_SOURCED" ]] && { run_bashrc; return; }

[[ -s ~/.profile ]] && . ~/.profile

[[ -s ~/.bash_profile.local ]] && . ~/.bash_profile.local

run_bashrc
