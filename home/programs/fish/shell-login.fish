#!/usr/bin/env fish

# configuration/home/programs/fish/login.sh
fish_add_path --move --prepend --path \
  $HOME/.nix-profile/bin /run/wrappers/bin \
  /etc/profiles/per-user/$USER/bin \
  /run/current-system/sw/bin \
  /nix/var/nix/profiles/default/bin

zoxide init fish | source

# Optional paths that are added only if they exist.
set optional_paths /opt/homebrew/bin $HOME/.cargo/bin

for path in $optional_paths
  if test -d $path
    fish_add_path $path
  end
end

# Initialize `pyenv` only if it's available.
if type -q pyenv
  pyenv init - fish | source
end
