{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      
      userName = "Onno Valkering";
      userEmail = "onnovalkering@users.noreply.github.com";

      aliases = {
        main = "checkout main";
        master = "checkout master";
        develop = "checkout develop";
      };

      signing = {
        key = "F62E7FE534146D64";
        signByDefault = true;
      };

      extraConfig = {
        core = {
          editor = "${pkgs.neovim}/bin/nvim";
          sshCommand = "/usr/bin/ssh";
        };
        format = {
          pretty = "format:%C(yellow)%h %Cblue%>(20)%ad %Cgreen%<(15)%aN%Cred%d %Creset%s";
        };
        log = {
          date = "relative";
          decorate = "short";
        };
        pull = {
          rebase = true;
        };
        status = {
          short = true;
        };
      };

      ignores = [
        ".DS_Store"
        ".env"
      ];
    };
  };
}
