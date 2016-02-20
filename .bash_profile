run_bashrc () { [[ "$-" =~ "i" ]] && [[ -s ~/.bashrc ]] && . ~/.bashrc; }
[[ -n "$BASH_PROFILE_DONE" ]] && run_bashrc && return
export BASH_PROFILE_DONE=1

[[ -s ~/.profile ]] && . ~/.profile

[[ -s ~/.bash_profile.local ]] && . ~/.bash_profile.local

run_bashrc
