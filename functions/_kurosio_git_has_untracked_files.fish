function _kurosio_git_has_untracked_files
  if _kurosio_git_is_repo
    set -l untracked_files (git ls-files --others --exclude-standard --directory --no-empty-directory)
    test -n "$untracked_files"
  else
    return 1
  end
end
