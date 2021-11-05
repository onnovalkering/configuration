{ pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
      
      userName = "Onno Valkering";
      userEmail = "onnovalkering@users.noreply.github.com";

      signing = {
        key = "0AB0702917844419";
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
