function _kurosio_git_branch_name
  set -l branch_name (git branch --show-current)
  if test -z "$branch_name"
    set -l tag_name (git describe --tags --exact-match HEAD 2>/dev/null)
    if test -z "$tag_name"
      set tag_name (git rev-parse --short HEAD 2>/dev/null)
    end
    printf "%s\n" "$tag_name"
  else
    printf "%s\n" "$branch_name"
  end
end
