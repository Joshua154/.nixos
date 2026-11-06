{pkgs, ...}: {
  home.packages = with pkgs; [
    discord

    legendary-gl
    prismlauncher
    wineWow64Packages.stable
  ];
}
