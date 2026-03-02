{pkgs, ...}: {
  home.packages = with pkgs; [
    # steam # enabled in system modules usually, but listed here in comment
    discord

    legendary-gl
    prismlauncher
    wineWowPackages.stable
    # lutris
    # protonup-qt
    # gamemode
    # mangohud
    # vkbasalt
    heroic

    # bottles
  ];
}
