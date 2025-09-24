{ config, pkgs, ... }:
{
  home.file = {
    ".p10k.zsh" = {
      source = ./p10k.zsh;
    };
  };

  home.packages = with pkgs; [
    lsd
  ];

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
      clip = "xclip -selection clipboard";
    };

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    initContent = ''
      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      # Shell integrations
      eval "$(zoxide init --cmd cd zsh)"

      [[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

      # Optional Ghostty support
      if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
        builtin source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
      fi
    '';
  };
}
