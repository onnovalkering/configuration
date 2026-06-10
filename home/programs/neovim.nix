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
      harpoon2

      # LSP & Completion
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
      noice-nvim
      nui-nvim
      nvim-notify
      render-markdown-nvim

      # Git
      diffview-nvim

      # Debug
      nvim-dap
      nvim-dap-ui
      nvim-dap-virtual-text

      # Yank
      yanky-nvim

      # Hardtime
      hardtime-nvim

      # Tmux integration
      vim-tmux-navigator
    ];

    extraPackages = with pkgs; [
      # Lua
      lua-language-server
      stylua

      # Python
      basedpyright
      ruff

      # Rust
      rust-analyzer

      # Nix
      nil
      nixfmt

      # TypeScript / JavaScript
      nodejs-slim_22
      typescript-language-server

      # Bash
      bash-language-server
      shfmt

      # JSON + HTML + CSS (vscode-langservers-extracted)
      vscode-langservers-extracted

      # YAML
      yaml-language-server

      # SQL
      sqls

      # Formatting
      prettier
    ];

    initLua = ''
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
