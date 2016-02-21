maybe_source_bashrc () { [[ "$-" =~ "i" ]] && [[ -s ~/.bashrc ]] && . ~/.bashrc; }

[[ -n "$PROFILE_SOURCED" ]] && { maybe_source_bashrc; return; }

[[ -s ~/.profile ]] && . ~/.profile

[[ -s ~/.bash_profile.local ]] && . ~/.bash_profile.local

maybe_source_bashrc
