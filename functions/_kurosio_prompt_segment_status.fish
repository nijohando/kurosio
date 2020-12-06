function _kurosio_prompt_segment_status
  if [ $_kurosio_exit_code -ne 0 ]
    set_color ffffff
    set_color -b $_kurosio_prompt_status_error_color
    echo -n " $_kurosio_exit_code "
    set_color normal
  end
end
