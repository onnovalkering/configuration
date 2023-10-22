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
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkAtn+2JTthPhy/lD6pa5/3A6tkGD+OBmdqeni7vz0s";
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
        gpg = {
          format = "ssh";
        };	
	     gpg.ssh = {
          program  = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
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