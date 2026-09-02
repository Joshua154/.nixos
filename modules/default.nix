{
  host,
  hostname,
  lib,
  ...
}: let
  profiles = host.profiles or (throw "Host '${hostname}' is missing its profiles configuration.");
  available = {
    boot = {
      grub-efi-removable = ./profiles/boot/grub-efi-removable.nix;
      secure-boot = ./profiles/boot/secure-boot.nix;
      systemd-boot = ./profiles/boot/systemd-boot.nix;
    };
    displayManagers = {
      gdm = ./profiles/display-managers/gdm.nix;
      ly = ./profiles/display-managers/ly.nix;
      sddm = ./profiles/display-managers/sddm.nix;
    };
    hardware = {
      amd = ./profiles/hardware/amd.nix;
      displaylink = ./profiles/hardware/displaylink.nix;
      intel = ./profiles/hardware/intel.nix;
      nvidia = ./profiles/hardware/nvidia.nix;
      nvidia-prime = ./profiles/hardware/nvidia-prime.nix;
    };
    networking = {
      networkmanager = ./profiles/networking/networkmanager.nix;
      openconnect = ./profiles/networking/openconnect.nix;
    };
    desktops = {
      bspwm = ./profiles/window-managers/bspwm.nix;
      gnome = ./profiles/window-managers/gnome.nix;
      hyprland = ./profiles/window-managers/hyprland.nix;
    };
    programs = {
      android = ./profiles/programs/android.nix;
      kdeconnect = ./profiles/programs/kdeconnect.nix;
      zoom = ./profiles/programs/zoom.nix;
    };
    services = {
      cloudflared = ./system/cloudflared.nix;
      localsend = ./system/localsend.nix;
      nfc = ./system/nfc.nix;
      samba = ./system/samba.nix;
      syncthing = ./system/syncthing.nix;
      tailscale = ./system/tailscale.nix;
    };
  };
  select = category: name:
    available.${category}.${name}
    or (throw "Unknown ${category} profile '${name}' for host '${hostname}'.");
  selectMany = category: names: map (select category) names;
in {
  imports =
    [
      ./system/shared.nix
      (select "boot" profiles.boot)
      (select "displayManagers" profiles.displayManager)
    ]
    ++ selectMany "hardware" profiles.hardware
    ++ selectMany "networking" profiles.networking
    ++ selectMany "desktops" profiles.desktops
    ++ selectMany "programs" (profiles.programs or [])
    ++ selectMany "services" (profiles.services or []);

  powerManagement.enable = lib.mkDefault true;
  programs.nix-ld.enable = lib.mkDefault (host.nixLd or false);
}
