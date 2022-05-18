{ pkgs, ... }:

{
  programs = {
    fish = {
      enable = true;

      shellInit = ''
        fish_vi_key_bindings
      '';

      loginShellInit = ''
        fish_add_path /opt/homebrew/bin
        fish_add_path --move --prepend --path \
          $HOME/.nix-profile/bin /run/wrappers/bin \
          /etc/profiles/per-user/$USER/bin \
          /run/current-system/sw/bin \
          /nix/var/nix/profiles/default/bin
      '';

      shellAbbrs = {
        c = "cargo";
        g = "git";
        k = "kubectl";
        n = "nvim";
        p = "podman";
        t = "tmux";
      };

      shellAliases = {
        cp = "cp --interactive --verbose";
        diff = "colordiff";
        grep = "rg --line-number --color=auto";
        la = "ls -l --classify --human-readable --color=auto --almost-all";
        ls = "ls -l --classify --human-readable --color=auto";
        mkdir = "mkdir --parents --verbose";
        mv = "mv --interactive --verbose";
        ping = "ping -c 5";
        pingf = "ping -c 100 -i .2";

        cb = "cargo build";
        cf = "cargo fmt";
        ch = "cargo check";
        cr = "cargo run";
        ct = "cargo test";
        cu = "cargo update";
        cy = "cargo clippy";

        ga = "git add";
        gb = "git branch";
        gc = "git commit";
        gd = "git diff";
        gf = "git fetch";
        gl = "git log --graph";
        gm = "git merge";
        gp = "git pull";
        gs = "git status";
        gt = "git tag";
        gt-d = "git tag --delete";
        gu = "git push origin";

        ta = "tmux attach";
        tk = "tmux kill-session -t";
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
    };
  };
}
