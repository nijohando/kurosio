function _kurosio_prompt_2nd_line
  set -l prompt_colors
  if [ $_kurosio_exit_code -eq 0 ]
    set prompt_colors $_kurosio_prompt_colors
  else
    set prompt_colors $_kurosio_prompt_error_colors
  end
  echo ""
  for i in (seq (count $_kurosio_prompt_chars))
    set_color $prompt_colors[$i]
    echo -n $_kurosio_prompt_chars[$i]
  end
end
