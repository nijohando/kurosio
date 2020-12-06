function _kurosio_prompt_segment_path
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
  set_color -b $_kurosio_prompt_path_bg_color
  if [ $cliped -eq 1 ]
    echo -n " "
    set -l h (string sub -l 9 -- $p)
    set p (string sub -s10 -- $p)
    for i in (seq 9)
      set_color $_kurosio_prompt_path_clip_edge_colors[$i]
      echo -n (string sub -s$i -l1 -- $h)
    end
    else
    echo -n " "
  end
  set_color $_kurosio_prompt_path_fg_color
  echo -n "$p "
  set_color normal
end
