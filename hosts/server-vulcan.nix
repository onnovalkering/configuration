{ inputs, self, ... }:
{
  flake.nixosConfigurations.server-vulcan =
    (import "${self}/hosts/lib" { inherit inputs self; }).mkNixos
      {
        hostName = "server-vulcan";
        modules = [
          "${self}/hardware/custom-silverstone.nix"
          "${self}/configurations/nixos/services"
        ];
      };
}
