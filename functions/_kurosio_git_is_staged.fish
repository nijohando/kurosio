function _kurosio_git_is_staged
  _kurosio_git_is_repo && not git diff --cached --no-ext-diff --quiet --exit-code 2>/dev/null
end
