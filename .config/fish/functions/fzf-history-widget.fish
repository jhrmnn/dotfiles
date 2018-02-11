function fzf-history-widget -d "Show command history"
  set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
  begin
    set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS +s --tiebreak=index $FZF_CTRL_R_OPTS +m"
    history --show-time=(set_color bryellow)'%Y-%m-%d %H:%M '(set_color normal) (test (count $argv) -eq 1; and printf -- "-n\n%s" $argv[1]; or printf -- '-n\n5000') | eval (__fzfcmd) -n 3.. --ansi -q '(commandline)' | string split ' ' -m 2 | tail -1 | read -l result
    and commandline -- $result
  end
  commandline -f repaint
end
