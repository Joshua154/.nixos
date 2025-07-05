{ config, pkgs, lib, inputs, username, hostname, ... }:
{
  imports = [
#    ./hyprland.nix
    ./gdm.nix
#    ./sddm.nix
  ];

  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "audio"
      "docker"
      "adbusers"
    ];
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  nix.settings.trusted-users = [ "root" "${username}" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [
    "xpdf-4.05"
    "openssl-1.1.1w"
  ];
  nixpkgs.config.allowUnsupportedSystem = true;

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  nix.settings.auto-optimise-store = true;

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  services = {
    xserver = {
      enable = true;
      desktopManager.gnome.enable = true;
      xkb.layout = "us";
    };
    
    #displayManager.sddm.enable = true;
    printing.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
    pulseaudio.enable = false;
  };
  
  #programs.hyprland.enable = true;
  
  programs.steam.enable = true;


  # wm
  #services.displayManager = {
  #  defaultSession = "none+bspwm";
  #};

  # touchpad config
  services.libinput = {
    enable = true;

    touchpad = {
      tapping = true;
      middleEmulation = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      newcomputermodern

      # nerdfonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono

    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  programs.dconf.enable = true;
  programs.adb.enable = true;

  #users.defaultUserShell = pkgs.fish;

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  # Install firefox.
  # programs.firefox.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    curl
    git

    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    
    # hyprland
#    hyprland
#    wayland-utils
#    xwayland
#    kitty

    gimp
    samba
  ];
  
  services.samba = {
    enable = true;
    openFirewall = true;
    
    smbd.enable = true;
    
    settings = {
      global = {
        security = "user";
        "workgroup" = "WORKGROUP";
        "server string" = "Samba Server";
        "map to guest" = "Bad User";
        "log file" = "/var/log/samba/log.%m";
        "max log size" = "50";
        "dns proxy" = "no";
        "invalid users" = [ "root" ];
      };
  
      "privateShare" = {
        path = "/home/${username}/privateShare";
        "read only" = "no";
        "guest ok" = "no";
        "browseable" = "yes";
      };
  
      "Public" = {
        path = "/home/${username}/Public";
        "read only" = "no";
        "guest ok" = "yes";
        "browseable" = "yes";
      };
    };
  };
  
  systemd.tmpfiles.rules = [
    "d /home/${username}/Public 0755 ${username} users -"
    "d /home/${username}/privateShare 0777 ${username} users -"
  ];


  environment.etc."current_system_packages".text =
    let
      packages = builtins.map (p: "${p.name}") config.environment.systemPackages;
      sortedUnique = builtins.sort builtins.lessThan (lib.unique packages);
      formatted = builtins.concatStringsSep "\n" sortedUnique;
    in
    formatted;

  programs.noisetorch = {
    enable = true;
  };

  # enable docker
  virtualisation.docker.enable = true;

  # use docker without Root access (Rootless docker)
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;

    settings = {
      General = {
        Name = "${hostname}";
        ControllerMode = "dual";
        FastConnectable = "true";
        Experimental = "true";
        Enable = "Source,Sink,Media,Socket";
      };

      Policy = {
        AutoEnable = "true";
      };
    };
  };
  services.blueman.enable = true;
  hardware.keyboard.qmk.enable = true;
  services.udev.packages = [ pkgs.via ];
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.mime.defaultApplications = {
    "image/png" = [
      "qimgv.desktop"
    ];
    "image/jpeg" = [
      "qimgv.desktop"
    ];
    "image/jpg" = [
      "qimgv.desktop"
    ];
  };
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];
}
