{ inputs, self, ... }:
{
  flake.nixosConfigurations.server-vesta =
    (import "${self}/hosts/lib" { inherit inputs self; }).mkNixos
      {
        hostName = "server-vesta";
        modules = [
          "${self}/hardware/intel-nuc-11-ess.nix"
          "${self}/configurations/nixos/containers/homebridge.nix"
          "${self}/configurations/nixos/containers/jellyfin.nix"
          "${self}/configurations/nixos/containers/owndns.nix"
          "${self}/configurations/nixos/services/openssh.nix"
          "${self}/configurations/nixos/services/tailscale.nix"
        ];
      };
}
