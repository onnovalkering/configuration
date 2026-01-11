{ pkgs, ... }:
{
  programs = {
    tmux = {
      enable = true;

      baseIndex = 1;
      escapeTime = 10;
      keyMode = "vi";
      mouse = true;
      shortcut = "a";
      terminal = "tmux-256color";

      plugins = with pkgs.tmuxPlugins; [
        continuum
        resurrect
        yank
        vim-tmux-navigator
      ];

      extraConfig = ''
        set -g status-position top
        set -g status-left ""
        set -g status-left-length 100
        set -g status-right ""
        set -g status-right-length 100

        set -ag status-right "#{E:@catppuccin_status_application}"
        set -ag status-right "#{E:@catppuccin_status_session}"

        bind k send-keys C-l
        bind K send-keys -R C-l \; clear-history
      '';
    };
  };

  catppuccin.tmux.enable = true;
  catppuccin.tmux.flavor = "mocha";
}
