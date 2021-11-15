{ pkgs, ... }:

{
  programs = {
    kitty = {
      enable = true;

      font = {
	name = "FiraCode Nerd Font";
      };
      
      settings = {
	macos_titlebar_color = "background";
	macos_thicken_font = "0.4";
      };

      extraConfig = ''
	# GitHub theme (dimmed) for Kitty
	# https://github.com/projekt0n/github-nvim-theme

	background #22272e
	foreground #768390
	selection_background #264466
	selection_foreground #768390
	url_color #768390
	cursor #6cb6ff

	# Tabs
	active_tab_background #6cb6ff
	active_tab_foreground #1e2228
	inactive_tab_background #768390
	inactive_tab_foreground #1e2228

	# Border
	active_border_color #444c56
	inactive_border_color #444c56

	# Colors
	color0 #22272e
	color1 #ff938a
	color2 #6bc46d
	color3 #c69026
	color4 #6cb6ff
	color5 #b083f0
	color6 #56d4dd
	color7 #636e7b

	color8 #636e7b
	color9 #ff938a
	color10 #6bc46d
	color11 #daaa3f
	color12 #6cb6ff
	color13 #dcbdfb
	color14 #56d4dd
	color15 #768390

	color16 #daaa3f
	color17 #ff938a
      '';
    };
  };
}
