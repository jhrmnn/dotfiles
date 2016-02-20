run_bashrc () { [[ "$-" =~ "i" ]] && [[ -s ~/.bashrc ]] && . ~/.bashrc; }
[[ -n "$PROFILE_SOURCED" ]] && run_bashrc && return
export PROFILE_SOURCED=1

[[ -s ~/.profile ]] && . ~/.profile

[[ -s ~/.bash_profile.local ]] && . ~/.bash_profile.local

run_bashrc
