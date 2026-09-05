{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    acpi
    bat
    btop
    capitaine-cursors
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
    nordic
    nordzy-icon-theme
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