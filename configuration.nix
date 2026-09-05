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
    tmp.cleanOnBoot = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 50;
  };

  hardware = {
    enableAllFirmware = true;
    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
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

  console.keyMap = "us";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      accept-flake-config = true;
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
    };
    libinput.enable = true;
    displayManager.defaultSession = "xfce";

    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;
    upower.enable = true;
    fwupd.enable = true;
    blueman.enable = true;

    picom = {
      enable = true;
      backend = "glx";
      vSync = true;
      settings = {
        blur = {
          method = "dual_kawase";
          strength = 5;
          background = true;
        };
        corner-radius = 12;
        rounded-corners-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
        ];
        shadow = true;
        shadow-radius = 15;
        shadow-opacity = 0.35;
        fading = true;
        fade-delta = 8;
      };
    };

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
        CPU_HWP_DYN_BOOST_ON_AC = 1;
        CPU_HWP_DYN_BOOST_ON_BAT = 0;
        USB_AUTOSUSPEND = 1;
        STOP_CHARGE_THRESH_BAT0 = 80;
      };
    };

    thermald.enable = true;

    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  powerManagement.enable = true;

  programs = {
    dconf.enable = true;
    xfconf.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
    zsh.enable = true;
    git.enable = true;
  };

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      jetbrains-mono
      inter
      noto-fonts
      noto-fonts-emoji
      nerd-fonts.jetbrains-mono
    ];
  };

  environment = {
    sessionVariables = {
      GTK_THEME = "Colloid-Dark-Nord";
      XCURSOR_THEME = "Bibata-Modern-Ice";
      XCURSOR_SIZE = "24";
    };
    variables.EDITOR = "nvim";
  };

  systemd.user.services.xfce-theming = {
    description = "Apply Nord visual upgrade";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "xfconf.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      ${lib.getExe pkgs.papirus-folders} -C nordic --theme Papirus-Dark || true
      ${lib.getExe pkgs.xfce.xfconf} -c xsettings -p /Net/ThemeName -s "Colloid-Dark-Nord" || true
      ${lib.getExe pkgs.xfce.xfconf} -c xsettings -p /Net/IconThemeName -s "Papirus-Dark" || true
      ${lib.getExe pkgs.xfce.xfconf} -c xsettings -p /Gtk/CursorThemeName -s "Bibata-Modern-Ice" || true
      ${lib.getExe pkgs.xfce.xfconf} -c xsettings -p /Gtk/CursorThemeSize -i 24 || true
      ${lib.getExe pkgs.xfce.xfconf} -c xfwm4 -p /general/theme -s "Colloid-Dark-Nord" || true
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