{ inputs, self, ... }:
{
  flake.darwinConfigurations.macbook-pro =
    (import "${self}/hosts/lib" { inherit inputs self; }).mkDarwin
      {
        hostName = "macbook-pro";
        modules = [
          "${self}/configurations/darwin/launch-agents"
          "${self}/configurations/darwin/launch-daemons"
          "${self}/configurations/darwin/services"
        ];
      };
}
