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
	packer-nvim
      ];
    };
  };

  home.file.".config/nvim/lua".source = ./files/neovim/lua;
}
