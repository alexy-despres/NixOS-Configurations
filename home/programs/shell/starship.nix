# starship is a minimal, fast, and extremely customizable prompt for any shell!
{config, ...}: let
  fg = "#${config.lib.stylix.colors.base05}";
in {
  programs.starship = {
    enable = true;
    settings = {
      git_status = {
        format = "[[\\[(*$conflicted$untracked$modified$staged$renamed$deleted)\\]](${fg})($ahead_behind$stashed)]($style)";
        style = "cyan";
        conflicted = "";
        renamed = "";
        deleted = "";
        stashed = "≡";
      };
    };
  };
}
