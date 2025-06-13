{ config, pkgs, ... }:
{
  home.file = {
    ".config/nvim" = {
      source = ./config;
      recursive = true;
    };
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    plugins = with pkgs.vimPlugins; [
      cmp-nvim-lsp
      vim-wakatime
    ];
  };
}
