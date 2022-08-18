{ pkgs, ... }:

{
  programs = {
    neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;

      extraConfig = ''
      	lua require('init')
      '';

      plugins = with pkgs.vimPlugins; [
        completion-nvim
        lspsaga-nvim
        lsp-status-nvim
        lualine-lsp-progress
        lualine-nvim
        nvim-lspconfig
        nvim-tree-lua
        nvim-treesitter
        nvim-web-devicons
        packer-nvim
        rust-tools-nvim
        telescope-fzy-native-nvim
        telescope-nvim
      ];
    };
  };

  home.file.".config/nvim/lua".source = ./files/neovim/lua;
}
