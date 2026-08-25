# ==========================================================
# Centrale pakkettenlijst voor het hele systeem
# ==========================================================


{ pkgs }:

with pkgs; [

  # ---- WEB BROWSERS ----
  librewolf        # privacy-vriendelijke Firefox-fork

  # ---- ESSENTIËLE COMMANDO'S ----
  git              # versiebeheer
  vim              # terminal-editor (of vervang door neovim)
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
  neofetch         # systeeminformatie (voor de lol)
  nix-index        # zoeken in nixpkgs (gebruik `nix-locate`)

  # ---- THEMA & ICONS ----
  gruvbox-gtk-theme 
  gruvbox-dark-icons-gtk 

  # ---- CURSOR THEMA
  capitaine-cursors

  # ---- LETTERTYPE
  jetbrains-mono
]