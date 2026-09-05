{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    librewolf
    (vscodium.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=x11";
    })

    git
    wget
    curl
    btop
    eza
    bat
    fd
    ripgrep
    tree
    unzip
    gzip
    ncdu
    rsync
    fastfetch
    nix-index
    xclip
    pavucontrol

    powertop
    acpi

    nordic
    nordzy-icon-theme
    capitaine-cursors

    libreoffice
    xfce.mousepad
  ];
}