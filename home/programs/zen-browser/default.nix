{inputs, ...}: {
  imports = [inputs.zen-browser.homeModules.beta];

  stylix.targets.zen-browser.profileNames = ["default"];
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    policies = let
      mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

      mkExtensionEntry = {
        id,
        pinned ? false,
      }: let
        base = {
          install_url = mkPluginUrl id;
          installation_mode = "force_installed";
        };
      in
        if pinned
        then base // {default_area = "navbar";}
        else base;

      mkExtensionSettings = builtins.mapAttrs (_: entry:
        if builtins.isAttrs entry
        then entry
        else mkExtensionEntry {id = entry;});
    in {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true; # save webs for later reading
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      SanitizeOnShutdown = {
        FormData = true;
        Cache = true;
      };
      ExtensionSettings = mkExtensionSettings {
        "uBlock0@raymondhill.net" = mkExtensionEntry {
          id = "ublock-origin";
          pinned = true;
        };
        "addon@darkreader.org" = mkExtensionEntry {
          id = "darkreader";
          pinned = true;
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = mkExtensionEntry {
          id = "bitwarden-password-manager";
          pinned = true;
        };
      };
    };

    profiles.default = {
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.urlbar.behavior" = "float";
      };

      search = {
        force = true;
        default = "ddg";
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Quick Links";
            toolbar = true;
            bookmarks = [
              {
                name = "GitHub";
                url = "https://github.com";
              }
            ];
          }
        ];
      };

      containersForce = true; # Delete containers not declared here

      spacesForce = true; # Delete spaces not declared here
      spaces = {
        "General" = {
          id = "c6de089c-410d-4206-961d-ab11f988d40a";
          position = 1000;
          icon = "🏠";
        };
        "Work" = {
          id = "cdd10fab-4fc5-494b-9041-325e5759195b";
          position = 2000;
          icon = "💼";
          container = 1;
        };
      };

      pinsForce = true;
      pinsForceAction = "remove"; # "remove" drops undeclared pins; default is "demote"
      pins = {
        "GitHub" = {
          id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
          url = "https://github.com";
          position = 101;
        };
      };

      keyboardShortcutsVersion = 19;
      keyboardShortcuts = [
        {
          id = "zen-compact-mode-toggle";
          key = "c";
          modifiers = {
            control = true;
            alt = true;
          };
        }
        {
          id = "key_quitApplication";
          disabled = true;
        }
      ];
    };
  };
}
