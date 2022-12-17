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
      ];
    };
  };

  home.file.".config/nvim/lua".source = ./files/neovim/lua;
}
