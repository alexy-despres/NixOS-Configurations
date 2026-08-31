{
  pkgs,
  config,
  ...
}: let
  cursorShaders = pkgs.fetchFromGitHub {
    owner = "sahaj-b";
    repo = "ghostty-cursor-shaders";
    rev = "06d4e90fb5410e9c4d0b3131584060adddf89406";
    hash = "sha256-G/UIr1bKnxn1AcHl/4FL/jou6b7M2VeREslYVELxdmw=";
  };
  cursorShaders2 = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/IT2669-Stephin/linux-ricing/fd2b3058adc886daa08c7d98a15d6ea70a8491a2/ghostty/shaders/perfection.glsl";
    hash = "sha256-8Mtw5AVPpWRbyKWpktOwc5o/3oYAYQlLIxihyxid710=";
  };
  c = config.lib.stylix.colors;
in {
  home.sessionVariables = {
    TERMINAL = "ghostty";
    TERM = "ghostty";
  };

  programs.ghostty = {
    enable = true;
    installVimSyntax = true;
    enableZshIntegration = true;
    settings = {
      window-padding-x = 10;
      confirm-close-surface = false;
      window-padding-y = 10;
      clipboard-read = "allow";
      clipboard-write = "allow";
      copy-on-select = "clipboard";
      app-notifications = false;
      custom-shader = "${cursorShaders}/cursor_warp.glsl";
      # custom-shader = "${cursorShaders2}";
      custom-shader-animation = "always";
      keybind = [
        "shift+ctrl+tab=new_tab"
      ];
    };
  };

  home.file.".config/ilovetui/config.yaml".text = ''
    colors:
      base00: "#${c.base00}" # Background
      base01: "#${c.base01}" # Lighter Background / Status Bars
      base02: "#${c.base02}" # Selection Background
      base03: "#${c.base03}" # Comments / Invisibles
      base04: "#${c.base04}" # Dark Foreground / Status Bars
      base05: "#${c.base05}" # Default Foreground
      base06: "#${c.base06}" # Light Foreground
      base07: "#${c.base07}" # Light Background
      base08: "#${c.base08}" # Variables / Errors / Diff Deleted
      base09: "#${c.base09}" # Integers / Constants / Booleans
      base0a: "#${c.base0A}" # Classes / Warnings / Search Background
      base0b: "#${c.base0B}" # Strings / Success / Diff Inserted
      base0c: "#${c.base0C}" # Support / Regex / Escape Characters
      base0d: "#${c.base0D}" # Functions / Methods / Headings / Accent
      base0e: "#${c.base0E}" # Keywords / Storage / Diff Changed
      base0f: "#${c.base0F}" # Embedded / Misc
  '';
}
