# ==========================================================
# Centrale pakkettenlijst voor het hele systeem
# ==========================================================

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # ---- WEB BROWSERS & EDITORS ----
    librewolf        # privacy-vriendelijke Firefox-fork
    (vscodium.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=x11";
    })

    # ---- ESSENTIËLE COMMANDO'S ----
    git              # versiebeheer
    wget             # bestanden downloaden
    curl             # HTTP-requests
    btop             # moderne versie van htop (mooier)
    tree             # directory-structuur tonen
    unzip            # .zip uitpakken
    gzip             # compressie
    ncdu             # schijfruimte analyseren (ncurses)
    rsync            # efficiënt synchroniseren
    fd               # snellere find
    ripgrep          # snellere grep
    fastfetch        # actieve en snellere opvolger van neofetch
    nix-index        # zoeken in nixpkgs (gebruik `nix-locate`)

    # ---- ENERGIE & BATTERIJ TOOLS ----
    powertop         # analyseer en beheer het energieverbruik van processen
    acpi             # eenvoudige batterijstatus via terminal

    # ---- THEMA & ICONS ----
    gruvbox-gtk-theme 
    gruvbox-dark-icons-gtk 

    # ---- CURSOR THEMA ----
    capitaine-cursors

    # ---- LETTERTYPE ----
    jetbrains-mono

    # ---- CLIPBOARD ----
    xclip

    # ---- OFFICE ----
    libreoffice
  ];
}