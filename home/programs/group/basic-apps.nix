{
  pkgs-stable,
  pkgs-nur-hadi,
  ...
}: {
  home.packages = with pkgs-stable; [
    # Desktop
    vlc # Video player
    spotify # Music player
    discord # Chatting app
    obsidian # Note taking app
    github-desktop # Github desktop
    resources # Ressource monitor
    onlyoffice-desktopeditors # Office suite
    librewolf # Backup browser

    # TUI
    caligula # User-friendly, lightweight TUI for disk imaging (ISO, USB BOOT)
    wikiman # Offline search engine for manual pages (arch wiki, tldr)
    pkgs-nur-hadi.usbguard-tui # TUI for managing USBGuard rules

    # CLI
    httpie # Command-line HTTP client, a user-friendly cURL replacement
    gh # GitHub
    gh-dash # A terminal dashboard for GitHub
  ];
}
