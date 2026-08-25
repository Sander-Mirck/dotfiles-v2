# ======================================================
# NixOS configuratie – Flake-versie
# ======================================================
# Dit bestand wordt gebruikt via de flake in dezelfde map.
# De hardware-configuratie wordt apart gehouden.

{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix   # gegenereerd door nixos-generate-config
    ];

  # ---- BOOTLOADER ----
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # ---- NETWERK ----
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;   # Gnome/KDE/automatisch

  # ---- LOCALE & TIJD ----
  time.timeZone = "Europe/Amsterdam";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS     = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY    = "nl_NL.UTF-8";
    LC_NAME        = "nl_NL.UTF-8";
    LC_NUMERIC     = "nl_NL.UTF-8";
    LC_PAPER       = "nl_NL.UTF-8";
    LC_TELEPHONE   = "nl_NL.UTF-8";
    LC_TIME        = "nl_NL.UTF-8";
  };

  # ---- X11 / DESKTOP (XFCE) ----
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # ---- PRINTEN ----
  services.printing.enable = true;

  # ---- GELUID (PipeWire) ----
  # PulseAudio is expliciet uit (PipeWire draait)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;   # alleen als je JACK nodig hebt
  };

  # ---- TOUCHPAD (standaard ingeschakeld in XFCE) ----
  # services.xserver.libinput.enable = true;   # meestal niet nodig

  # ---- GEBRUIKERS ----
  users.users."sander" = {
    isNormalUser = true;
    description  = "Sander Mirck";
    extraGroups  = [ "networkmanager" "wheel" ];
    # Gebruikerspecifieke packages kunnen hier, maar we beheren ze centraal in packages.nix
  };

  # ---- PAKKETTEN (centraal beheerd) ----
  environment.systemPackages = (import ./packages.nix) { inherit pkgs; };

  # ---- FIREFOX VERWIJDERD (Librewolf vervangt het) ----
  # programs.firefox.enable = false;   # overbodig, staat standaard uit

  # ---- ONVRIJE PAKKETTEN TOESTAAN ----
  nixpkgs.config.allowUnfree = true;

  # ---- FLAKES ONDERSTEUNING ----
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ---- SYSTEEMVERSIE (blijf bij 24.11) ----
  system.stateVersion = "24.11";
}