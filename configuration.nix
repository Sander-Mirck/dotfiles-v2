# ======================================================
# NixOS configuratie – Flake-versie
# ======================================================
# Dit bestand wordt gebruikt via de flake in dezelfde map.
# De hardware-configuratie wordt apart gehouden.

{ config, pkgs, ... }:

{
  imports =
    [ ./hardware-configuration.nix
      ./neovim.nix
      ./packages.nix
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

  # ---- XFCE THEMA & ICONEN ----
  # Zet het GTK-thema en iconen vast voor alle gebruikers
  environment.sessionVariables = {
    GTK_THEME = "Gruvbox-Dark";
  };

  # XFCE-specifieke instellingen via xfconf (de XFCE-configuratie-database)
  systemd.user.services."xfce-theme-setup" = {
    description = "Set XFCE theme to Gruvbox";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xsettings -p /Net/ThemeName -s 'Gruvbox-Dark'";
      RemainAfterExit = true;
    };
  };

  systemd.user.services."xfce-icon-setup" = {
    description = "Set XFCE icon theme to Gruvbox";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.xfce.xfconf}/bin/xfconf-query -c xsettings -p /Net/IconThemeName -s 'Gruvbox-Dark'";
      RemainAfterExit = true;
    };
  };

  # ---- PRINTEN ----
  services.printing.enable = true;

  # ---- GELUID (PipeWire) ----
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # ---- GEBRUIKERS ----
  users.users."sander" = {
    isNormalUser = true;
    description  = "Sander Mirck";
    extraGroups  = [ "networkmanager" "wheel" ];
  };

  # ---- ONVRIJE PAKKETTEN TOESTAAN ----
  nixpkgs.config.allowUnfree = true;

  # ---- FLAKES ONDERSTEUNING ----
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # ---- SYSTEEMVERSIE ----
  system.stateVersion = "24.11";
}