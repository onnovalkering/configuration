{ pkgs, ... }:

{
  programs = {
    fish = {
      enable = true;

      shellInit = ''
        fish_vi_key_bindings
      '';

      shellAbbrs = {
        c = "cargo";
        g = "git";
        k = "kubectl";
        n = "nvim";
        t = "tmux";
      };

      shellAliases = {
        cp = "cp --interactive --verbose";
        diff = "colordiff"
        grep = "rg --line-number --color=auto";
        ls = "ls -l --classify --human-readable --color=auto";
        la = "ls -l --classify --human-readable --color=auto --almost-all";
        mkdir = "mkdir --parents --verbose";
        mv = "mv --interactive --verbose";

        # TODO:
        # - cargo
        # - git
        # - kubectl
        # - tmux
      };

      functions = {
        fish_greeting = {
          body = "";
        };

        compress = {
          body = "echo 'Not yet implemented'";
        };

        decrypt = {
          body = "echo 'Not yet implemented'";
        };

        download = {
          body = "echo 'Not yet implemented'";
        };

        encrypt = {
          body = "echo 'Not yet implemented'";
        };
        
        extract = {
          body = "echo 'Not yet implemented'";
        };

        hash = {
          body = "echo 'Not yet implemented'";
        };
      };

      plugins = [
        {
          name = "nix-env";
          src = pkgs.fetchFromGitHub {
            owner = "lilyball";
            repo = "nix-env.fish";
            rev = "00c6cc762427efe08ac0bd0d1b1d12048d3ca727";
            sha256 = "1hrl22dd0aaszdanhvddvqz3aq40jp9zi2zn0v1hjnf7fx4bgpma";
          };
        }
      ];
    };
  };
}
