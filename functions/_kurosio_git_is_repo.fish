function _kurosio_git_is_repo
  git rev-parse --git-dir > /dev/null 2>/dev/null
end
