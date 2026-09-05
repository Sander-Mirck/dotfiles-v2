{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- VISUAL 1000x ---
    colloid-gtk-theme
    papirus-icon-theme
    tela-circle-icon-theme
    bibata-cursors
    papirus-folders

    # --- apps ---
    acpi
    bat
    btop
    curl
    eza
    fastfetch
    fd
    git
    gzip
    librewolf
    libreoffice
    ncdu
    nix-index
    nvd
    pavucontrol
    powertop
    ripgrep
    rsync
    tree
    unzip
    wget
    xclip
    xfce.mousepad

    (vscodium.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=x11";
    })
  ];
}