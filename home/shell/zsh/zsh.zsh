# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(zoxide init --cmd cd zsh)"

# Optional Ghostty support
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
  builtin source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi
