#!/usr/bin/env bash
set -euo pipefail

# Generates an age identity at ~/.config/sops/age/keys.txt if one does not
# already exist. Intended to be called from home-manager's home.activation.
#
# Usage: generate-age-key.sh <age-keygen-path>
#   age-keygen-path  absolute path to the age-keygen binary (from nix store)

age_keygen="${1:?usage: generate-age-key.sh <age-keygen-path>}"
key="$HOME/.config/sops/age/keys.txt"

if [ -f "$key" ]; then
    exit 0
fi

mkdir -p "$(dirname "$key")"
"$age_keygen" -o "$key"
chmod 600 "$key"
