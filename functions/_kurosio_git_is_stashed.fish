function _kurosio_git_is_stashed
  if _kurosio_git_is_repo
    git rev-parse --verify --quiet refs/stash > /dev/null 2>/dev/null
  end
end
