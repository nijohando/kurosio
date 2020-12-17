function _kurosio_git_is_stashed
  _kurosio_git_is_repo && git rev-parse --verify --quiet refs/stash > /dev/null 2>/dev/null
end
