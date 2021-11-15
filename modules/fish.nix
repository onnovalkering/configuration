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
	ping = "ping -c 5";
	pingf = "ping -c 100 -i .2";
        cp = "cp --interactive --verbose";
        diff = "colordiff";
        grep = "rg --line-number --color=auto";
        la = "ls -l --classify --human-readable --color=auto --almost-all";
        ls = "ls -l --classify --human-readable --color=auto";
        mkdir = "mkdir --parents --verbose";
        mv = "mv --interactive --verbose";

	cb = "cargo build";
	ch = "cargo check";
	cr = "cargo run";
	ct = "cargo test";
	cu = "cargo update";
	cy = "cargo clippy";

	ga = "git add";
	gb = "git branch";
	gc = "git commit";
	gd = "git diff";
	gl = "git log --graph";
	gm = "git merge";
	gp = "git pull";
	gs = "git status";
	gt = "git tag";
	gt-d = "git tag --delete";
	gu = "git push origin";

	ka = "kubectl attach";
	kc = "kubectl create";
	kcj = "kubectl get cronjob";
	kcj-d = "kubectl delete cronjob";
	kcm = "kubectl get configmaps";
	kcm-d = "kubectl delete configmaps";
	kcs = "kubectl get clusterstatus";
	kctx = "kubectl config current-context";
	kctx-s = "kubectl config use-context";
	kd = "kubectl describe";
	kde = "kubectl get deploy";
	kde-d = "kubectl delete deploy";
	ke = "kubectl exec -it";
	kep = "kubectl get endpoints";
	kep-d = "kubectl delete endpoints";
	kev = "kubectl get ev";
	kin = "kubectl get ing";
	kin-d = "kubectl delete ing";
	kj = "kubectl get job";
	kj-d = "kubectl delete job";
	kl = "kubectl get logs";
	kno = "kubectl get nodes";
	kns = "kubectl get namespace";
	kns-d = "kubectl delete namespace";
	kns-s = "kubectl config set-context (kubectl config current-context) --namespace";
	kpo = "kubectl get pods";
	kpo-d = "kubectl delete pods";
	kr = "kubectl run";

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
