function _kurosio_git_is_detached_head
  if _kurosio_git_is_repo
    not git symbolic-ref HEAD 2>/dev/null > /dev/null
  end
end
