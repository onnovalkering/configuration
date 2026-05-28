{ inputs, ... }:
{
  perSystem =
    {
      config,
      pkgs,
      system,
      ...
    }:
    {
      checks.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          deadnix.enable = true;
          luacheck.enable = true;
          nixfmt.enable = true;
          prettier.enable = true;
          shellcheck.enable = true;
          shfmt = {
            enable = true;
            settings.indent = 4;
          };
          statix.enable = true;
          stylua.enable = true;
          typos.enable = true;
        };
      };

      devShells.default = pkgs.mkShell {
        inherit (config.checks.pre-commit-check) shellHook;

        buildInputs = with pkgs; [
          deadnix
          nil
          nixfmt
          statix
        ];
      };
    };
}
