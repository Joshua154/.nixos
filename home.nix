{ config, pkgs, lib, ... }@args:

let
  configDir = args.configDir;
  configFiles = builtins.attrNames (builtins.readDir configDir);
  sourcedFiles = lib.concatStringsSep "\n" (
    map (file: "source ${builtins.toString configDir}/${file}") configFiles
  );
in 
{
  home.username = "joshua";
  home.homeDirectory = "/home/joshua";

  home.stateVersion = "25.05";
  home.packages = with pkgs; [
    texlive.combined.scheme-full
  ];
  home.file = {
    "Pictures" = {
      source = ./images;
      recursive = true;
    };
  };
  home.sessionVariables = { 
    #EDITOR = "nvim"; 
    #ZDOTDIR = "/home/joshua";
  };

  gtk = {
    cursorTheme = {
      name = "Future-cyan";
      size = 40;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 22;
  };

  programs.ghostty = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
      font-size = 14;
      background-blur-radius = 20;
      mouse-hide-while-typing = true;
      window-decoration = true;
      # keybind = global:cmd+/=toggle_quick_terminal;
      macos-option-as-alt = true;
      # background-opacity = 0.7;
      # background-blur-radius = 20;
    };
    #enableZshIntegration = true;
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history = {
      size = 5000;
      save = 5000;
      share = true;
      ignoreSpace = true;
      ignoreDups = true;
      expireDuplicatesFirst = true;
    };

    shellAliases = {
      ls = "lsd";
      #vim = "nvim";
      c = "clear";
      uniupdate = "git add .; git commit -m update; git push";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = sourcedFiles;
  };

  programs.home-manager.enable = true;
}
