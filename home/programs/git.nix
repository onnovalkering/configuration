{ pkgs, ... }:
{
  programs = {
    git = {
      enable = true;

      signing = {
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIkAtn+2JTthPhy/lD6pa5/3A6tkGD+OBmdqeni7vz0s";
        signByDefault = true;
      };

      settings = {
        user = {
          name = "Onno Valkering";
          email = "onnovalkering@users.noreply.github.com";
        };
        alias = {
          main = "checkout main";
          develop = "checkout develop";
        };
        core = {
          editor = "${pkgs.vim}/bin/vim";
          sshCommand = "${pkgs.openssh}/bin/ssh";
        };
        format = {
          pretty = "format:%C(yellow)%h %Cblue%>(20)%ad %Cgreen%<(15)%aN%Cred%d %Creset%s";
        };
        gpg = {
          format = "ssh";
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
        ".agents"
        ".env"
      ];
    };
  };
}
