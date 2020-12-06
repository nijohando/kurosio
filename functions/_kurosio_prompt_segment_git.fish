function _kurosio_prompt_segment_git
  if not _kurosio_git_is_repo
    return 1
  end
  set -l branch_bg_color
  set -l branch_fg_color
  if _kurosio_git_is_staged
    set branch_bg_color $_kurosio_prompt_git_staged_bg_color
    set branch_fg_color $_kurosio_prompt_git_staged_fg_color
    if _kurosio_git_is_dirty
      set_color -b $_kurosio_prompt_git_dirty_bg_color
      set_color $_kurosio_prompt_git_dirty_fg_color
      echo -n " "
    end
  else if _kurosio_git_is_dirty
    set branch_bg_color $_kurosio_prompt_git_dirty_bg_color
    set branch_fg_color $_kurosio_prompt_git_dirty_fg_color
  else
    set branch_bg_color $_kurosio_prompt_git_clean_bg_color
    set branch_fg_color $_kurosio_prompt_git_clean_fg_color
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
  if _kurosio_git_is_stashed
    echo -n $_kurosio_prompt_git_stashed_symbol
  else
    echo -n ' '
  end
  set_color normal
end
