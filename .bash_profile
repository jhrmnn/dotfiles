# echo "I am bash profile"
# [[ "$str" == -* ]] && echo "I am login shell"
if [[ -n "$BASH_PROFILE_DONE" ]]; then
    # echo "bash profile already processed, quitting"
    return
fi
export BASH_PROFILE_DONE=1
# echo "processing bash profile"

[[ -s ~/.profile ]] && . ~/.profile

[[ -s ~/.bash_profile.local ]] && . ~/.bash_profile.local

if [[ "$-" =~ "i" ]]; then
    # echo "bash profile is interactive, will run bashrc"
    [[ -s ~/.bashrc ]] && . ~/.bashrc
# else
    # echo "bash profile is non-interactive"
fi
