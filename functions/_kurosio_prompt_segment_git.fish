function _kurosio_prompt_segment_git
  if not _kurosio_git_is_repo
    return 1
  end
  set -l branch_bg_color
  set -l branch_fg_color
  set -l has_untracked_files 1
  set -l is_stashed 1
  if _kurosio_git_is_staged
    set branch_bg_color $_kurosio_prompt_git_staged_bg_color
    set branch_fg_color $_kurosio_prompt_git_staged_fg_color
    if _kurosio_git_is_dirty
      set_color -b $_kurosio_prompt_git_dirty_bg_color
      set_color $_kurosio_prompt_git_dirty_fg_color
      echo -n " "
    end
  else
    _kurosio_git_has_untracked_files
    set has_untracked_files $status
    _kurosio_git_is_dirty
    set -l is_dirty $status
    if test $has_untracked_files -eq 0 -o $is_dirty -eq 0
      set branch_bg_color $_kurosio_prompt_git_dirty_bg_color
      set branch_fg_color $_kurosio_prompt_git_dirty_fg_color
    else
      set branch_bg_color $_kurosio_prompt_git_clean_bg_color
      set branch_fg_color $_kurosio_prompt_git_clean_fg_color
    end
  end
  set_color -b $branch_bg_color
  set_color $branch_fg_color
  if _kurosio_git_is_detached_head
    echo -n $_kurosio_prompt_git_detached_head_symbol
  else
    echo -n $_kurosio_prompt_git_branch_symbol
  end
  echo -n (_kurosio_git_branch_name)
  set -l ahead (_kurosio_git_ahead)
  echo -n $ahead
  if test -n $ahead
    echo -n ' '
  end
  _kurosio_git_is_stashed
  set is_stashed $status
  if test $is_stashed -eq 0
    echo -n $_kurosio_prompt_git_stashed_symbol
  end
  if test $has_untracked_files -eq 0
    echo -n $_kurosio_prompt_git_untracked_files_symbol
  end
  if test $is_stashed -ne 0 -a $has_untracked_files -ne 0
    echo -n ' '
  end
  set_color normal
end
