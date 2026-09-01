{
  programs.kitty = {
    enable = true;
    settings = {
      font_size = "17.0";
      confirm_os_window_close = 0;
    };

    extraConfig = ''
      include colors-live.conf
    '';
  };
  programs.btop = {
    enable = true;
    settings = {
      color_theme = "matugen";
      theme_background = false;
      truecolor = true;
      vim_keys = false;
    };
  };
}
