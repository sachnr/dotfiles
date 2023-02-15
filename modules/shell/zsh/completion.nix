''
  zmodload -i zsh/complist

  unsetopt menu_complete   # do not autoselect the first completion entry
  unsetopt flowcontrol
  setopt auto_menu         # show completion menu on successive tab press
  setopt complete_in_word
  setopt always_to_end

  # case insensitive
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

  zstyle ':completion:*' menu select
  zstyle ':completion:*' list-dirs-first true
  bindkey -M menuselect '^[[Z' reverse-menu-complete

  # Use caching so that commands like apt and dpkg complete are useable
  zstyle ':completion:*' use-cache yes
  zstyle ':completion:*' coache-path $ZSH_CACHE_DIR
  export LS_COLORS="di=1;34:ln=36:so=1;31:pi=33:ex=1;32:bd=1;33:cd=1;33:su=1;33:sg=33:tw=30;42:ow=30;43"
  # ls colors
   zstyle ':completion:*' list-colors ""
   zstyle ':completion:*:default' list-colors ''${(s.:.)LS_COLORS}
''
