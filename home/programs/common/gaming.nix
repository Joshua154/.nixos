{pkgs, ...}: {
  home.packages = with pkgs; [
    # steam # enabled in system modules usually, but listed here in comment
    discord

    legendary-gl
    prismlauncher
    wineWow64Packages.stable
    # lutris
    # protonup-qt
    # gamemode
    # mangohud
    # vkbasalt
    # heroic

    # bottles
  ];
}
