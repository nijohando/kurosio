function _kurosio_git_is_dirty
  if _kurosio_git_is_repo
    not git diff --no-ext-diff --quiet --exit-code 2>/dev/null
  end
end
