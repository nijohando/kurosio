function _kurosio_git_ahead
  set -l counts (git rev-list --count --left-right "@{upstream}...HEAD" 2>/dev/null)
  if set -l pair (string match -r '(\d+)\s+(\d+)' $counts)
      set -l upstream $pair[2]
      set -l head $pair[3]
      if test $upstream -eq 0 -a $head -eq 0
        # equals to upstream
        printf ''
      else if test $upstream -ge 1 -a $head -eq 0
        # behind upstream
        printf '-'
      else if test $upstream -eq 0 -a $head -ge 1
        # ahead of upstream
        printf '+'
      else
        # diverged from upstream
        printf '±'
      end
  else
    printf ''
  end
end
