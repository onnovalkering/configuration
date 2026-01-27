{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      # Treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects

      # Core utilities
      plenary-nvim
      nvim-web-devicons
      which-key-nvim
      mini-nvim

      # Navigation
      telescope-nvim
      telescope-fzf-native-nvim
      flash-nvim
      oil-nvim
      gitsigns-nvim
      aerial-nvim
      trouble-nvim

      # LSP & Completion
      nvim-lspconfig
      blink-cmp
      friendly-snippets
      lazydev-nvim
      rustaceanvim

      # AI
      copilot-lua
      CopilotChat-nvim

      # UI
      lualine-nvim
      indent-blankline-nvim
      todo-comments-nvim
      conform-nvim

      # Tmux integration
      vim-tmux-navigator
    ];

    extraPackages = with pkgs; [
      # Lua
      lua-language-server

      # Python
      basedpyright
      ruff

      # Rust
      rust-analyzer

      # Nix
      nil
      nixfmt-rfc-style
    ];

    extraLuaConfig = ''
      require("config")
      require("lsp")
      require("plugins")
    '';
  };

  xdg.configFile."nvim/lua" = {
    source = ./neovim;
    recursive = true;
  };

  catppuccin.nvim = {
    enable = true;
    flavor = "mocha";
  };
}
