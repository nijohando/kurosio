set -g kurosio_path_bg_color 333333
set -g kurosio_path_fg_color cccccc
set -g kurosio_path_clip_edge_colors 444444 555555 666666 777777 888888 999999 aaaaaa bbbbbb cccccc
set -g kurosio_prompt_colors 2c7ecc 67c7ee 777777
set -g kurosio_prompt_chars \uf460 \uf460 \uf460
set -g kurosio_exit_status_error_color d0364f
set -g kurosio_git_branch_symbol ' '\ue0a0' '
set -g kurosio_git_detached_head_symbol ' '\uf417' '
set -g kurosio_git_stashed_symbol ' '\uf02d'  '
set -g kurosio_git_dirty_bg_color e45072
set -g kurosio_git_dirty_fg_color ffffff
set -g kurosio_git_staged_bg_color f8b02a
set -g kurosio_git_staged_fg_color 000000
set -g kurosio_git_touched_bg_color e45072
set -g kurosio_git_touched_fg_color ffffff
set -g kurosio_git_clean_bg_color a8cb10
set -g kurosio_git_clean_fg_color 000000

function __kurosio_max_path_length
  echo (math -s0 $COLUMNS / 1.2)
end

function __kurosio_ui_exit_status
  if [ $status -ne 0 ]
    set_color ffffff
    set_color -b $kurosio_exit_status_error_color
    echo -n ' ! '
  end
  set_color normal
end

function __kurosio_ui_path
  set -l p (string replace $HOME '~' $PWD)
  set -l maxlen (math -s0 $COLUMNS / 1.7)
  set -l len (string length $p)
  set -l cliped
  if [ $len -le $maxlen ]
    set cliped 0
  else
    set -l i (math $len - $maxlen + 1)
    set p (string sub -s$i $p)
    set cliped 1
  end
  set_color -b $kurosio_path_bg_color
  if [ $cliped -eq 1 ]
    echo -n " "
    set -l h (string sub -l 9 -- $p)
    set p (string sub -s10 -- $p)
    for i in (seq 9)
      set_color $kurosio_path_clip_edge_colors[$i]
      echo -n (string sub -s$i -l1 -- $h)
    end
    else
    echo -n " "
  end
  set_color $kurosio_path_fg_color
  echo -n "$p "
  set_color normal
end

function __kurosio_ui_git
  if not git_is_repo
    return 1
  end
  set -l branch_bg_color
  set -l branch_fg_color
  if git_is_staged
    set branch_bg_color $kurosio_git_staged_bg_color
    set branch_fg_color $kurosio_git_staged_fg_color
    if git_is_dirty 
      set_color -b $kurosio_git_dirty_bg_color
      set_color $kurosio_git_dirty_fg_color
      echo -n " "
    end
  else if git_is_dirty
    set branch_bg_color $kurosio_git_dirty_bg_color
    set branch_fg_color $kurosio_git_dirty_fg_color
  else if git_is_touched
    set branch_bg_color $kurosio_git_touched_bg_color
    set branch_fg_color $kurosio_git_touched_fg_color
  else
    set branch_bg_color $kurosio_git_clean_bg_color
    set branch_fg_color $kurosio_git_clean_fg_color
  end
  set_color -b $branch_bg_color
  set_color $branch_fg_color
  if git_is_detached_head
    echo -n $kurosio_git_detached_head_symbol
  else
    echo -n $kurosio_git_branch_symbol
  end
  echo -n (git_branch_name)
  set -l ahead (git_ahead)
  echo -n $ahead
  if [ -n $ahead ]
    echo -n ' '
  end
  if git_is_stashed
    echo -n $kurosio_git_stashed_symbol
  else
    echo -n ' '
  end
  set_color normal
end

function fish_prompt
  __kurosio_ui_exit_status
  __kurosio_ui_path
  __kurosio_ui_git
  echo ""
  for i in (seq (count $kurosio_prompt_chars))
    set_color $kurosio_prompt_colors[$i]
    echo -n $kurosio_prompt_chars[$i]
  end
  echo -n ' '
  set_color normal
end

