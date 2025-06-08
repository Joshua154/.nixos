{ config, pkgs, lib, ... }:
  
{
    imports = [ ./hardware-configuration.nix ];
    
    programs.kdeconnect.enable = true;
    
    boot = {
      kernelParams = [ "quiet" "splash" ];
      plymouth = {
        enable = true;
        theme = "breeze";
        #theme = "bgrt";
        #theme = "nixos-logo";
        #theme = "nixos-text";
      };
      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };
      initrd.luks.devices."luks-d29bd87d-47d8-4ba3-9e7a-087e4a02a0de".device = "/dev/disk/by-uuid/d29bd87d-47d8-4ba3-9e7a-087e4a02a0de";
    };
    
    networking = {
      hostName = "JNix";
      networkmanager.enable = true;
    };
    
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
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
        xkb.layout = "us";
      };
      printing.enable = true;
      pipewire = {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
      };
    };
    
    users.users.joshua = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
    };
    
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
    
    virtualisation.docker.enable = true;
    
    nix = {
      gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 1d";
      };
      settings.experimental-features = [ "nix-command" "flakes" ];
    };
    
    environment.systemPackages = with pkgs; [
      wget
      git
      neovim
      fzf
      lsd
      zoxide
      ghostty
      gromit-mpx
      direnv
      
      obsidian
      #vesktop
      discord
      termius
      jetbrains-toolbox
      kdePackages.kdeconnect-kde
      gnomeExtensions.gsconnect
      celluloid
      thunderbird
      bitwarden

      jdk21_headless
      python312

      steam
      spotify
      prismlauncher
      legendary-gl
      wineWowPackages.stable

    ];
    
    programs = {
      firefox = {
        enable = true;
        package = pkgs.latest.firefox-nightly-bin;
      };
      zsh.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
      };
    };
    
    nixpkgs = {
      config = {
        allowUnfree = true;
        allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
          "steam" "steam-original" "steam-unwrapped" "steam-run"
        ];
      };
      overlays = let
        moz-url = builtins.fetchTarball "https://github.com/mozilla/nixpkgs-mozilla/archive/master.tar.gz";
      in [ (import "${moz-url}/firefox-overlay.nix") ];
    };
    
    hardware = {
      graphics.enable = true;
      
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = true;
        nvidiaSettings = true;
      };
    };
    
    system.stateVersion = "25.05";
}
