{
  pkgs-bleeding,
  pkgs-stable,
  pkgs,
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
    # librewolf # Backup browser
    localsend # Send files to another device on the same network
    pkgs-bleeding.protonmail-desktop # Mail client
    pkgs-bleeding.proton-vpn # Main VPN client
    prismlauncher
    wl-mirror

    # TUI
    caligula # User-friendly, lightweight TUI for disk imaging (ISO, USB BOOT)
    wikiman # Offline search engine for manual pages (arch wiki, tldr)
    pkgs.ani-cli # Search/watch animes directly from the terminal (needs a video player)

    # CLI
    httpie # Command-line HTTP client, a user-friendly cURL replacement
    gh # GitHub
    gh-dash # A terminal dashboard for GitHub
  ];
}
