_: {
  programs = {
    fish = {
      enable = true;

      shellInit = builtins.readFile ./fish/shell-init.fish;
      loginShellInit = builtins.readFile ./fish/shell-login.fish;

      shellAbbrs = {
        b = "bat";
        c = "cargo";
        g = "git";
        k = "kubectl";
        t = "tmux";
        v = "vim";
        y = "yazi";
      };

      shellAliases = {
        cd = "z";
        cp = "cp --interactive --verbose";
        diff = "colordiff";
        grep = "rg --line-number --color=auto";
        la = "ls -l --classify --group-directories-first --human-readable --color=auto --almost-all";
        ls = "ls -l --classify --group-directories-first --human-readable --color=auto";
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
        gca = "git commit --amend";
        gd = "git diff";
        gf = "git fetch";
        gl = "git log --graph";
        gm = "git merge";
        gp = "git pull";
        gs = "git status";
        gt = "git tag";
        gtd = "git tag --delete";
        gu = "git push origin";
        guf = "git push origin --force-with-lease";

        kctx = "kubectl config get-contexts";
        kctx-set = "kubectl config use-context";
        kns = "kubectl get namespaces";
        kns-set = "kubectl config set-context --current --namespace";
        kpo = "kubectl get pods";
        kpo-del = "kubectl delete pods";
        ksvc = "kubectl get services";
        ksvc-del = "kubectl delete services";
        kdeploy = "kubectl get deployments";
        kdeploy-del = "kubectl delete deployments";
        krs = "kubectl get replicasets";
        krs-del = "kubectl delete replicasets";
        kjob = "kubectl get jobs";
        kjob-del = "kubectl delete jobs";
        kno = "kubectl get nodes";
        kpv = "kubectl get persistentvolumes";
        kpv-del = "kubectl delete persistentvolumes";
        kpvc = "kubectl get persistentvolumeclaims";
        kpvc-del = "kubectl delete persistentvolumeclaims";

        ta = "tmux attach";
        tk = "tmux kill-session -t";
      };

      functions = {
        fish_user_key_bindings = {
          body = ''
            bind -M insert \cf end-of-line
            bind -M insert \ce forward-word
          '';
        };
      };
    };
  };

  catppuccin.fish.enable = true;
  catppuccin.fish.flavor = "mocha";
}
