function fish_right_prompt --description 'bobthefish is all about the right prompt'
        set -l __bobthefish_left_arrow_glyph \uE0B3
  if [ "$theme_powerline_fonts" = "no" ]
    set __bobthefish_left_arrow_glyph '<'
  end

  set_color 555 white brblack

  __bobthefish_cmd_duration
  __bobthefish_timestamp
  set_color normal
end
