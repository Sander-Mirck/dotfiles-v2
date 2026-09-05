{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./packages.nix
    ./neovim.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "nl_NL.UTF-8";
      LC_IDENTIFICATION = "nl_NL.UTF-8";
      LC_MEASUREMENT = "nl_NL.UTF-8";
      LC_MONETARY = "nl_NL.UTF-8";
      LC_NAME = "nl_NL.UTF-8";
      LC_NUMERIC = "nl_NL.UTF-8";
      LC_PAPER = "nl_NL.UTF-8";
      LC_TELEPHONE = "nl_NL.UTF-8";
      LC_TIME = "nl_NL.UTF-8";
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      trusted-users = [ "root" "sander" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  services = {
    xserver = {
      enable = true;
      xkb.layout = "us";
      displayManager.lightdm.enable = true;
      desktopManager.xfce.enable = true;
      libinput.enable = true;
    };

    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    power-profiles-daemon.enable = false;
    tlp = {
      enable = true;
      settings = {
        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        USB_AUTOSUSPEND = 1;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    thermald.enable = true;
  };

  powerManagement.enable = true;
  security.rtkit.enable = true;
  hardware.bluetooth.enable = true;

  programs = {
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
    zsh.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      noto-fonts
      noto-fonts-emoji
    ];
  };

  environment = {
    sessionVariables.GTK_THEME = "Nordic";
    variables.EDITOR = "nvim";
  };

  systemd.user.services.xfce-theming = {
    description = "Apply Nord theme to XFCE";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "xfconf.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${lib.getExe pkgs.xfce.xfconf} -c xsettings -p /Net/ThemeName -s "Nordic" || true
      ${lib.getExe pkgs.xfce.xfconf} -c xsettings -p /Net/IconThemeName -s "Nordzy-dark" || true
    '';
  };

  users.users.sander = {
    isNormalUser = true;
    description = "Sander Mirck";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "24.11";
}