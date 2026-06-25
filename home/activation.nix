{ pkgs, lib, ... }:
{
  home.activation.generateAgeKey = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${pkgs.bash}/bin/bash ${./files/generate-age-key.sh} ${pkgs.age}/bin/age-keygen
  '';
}
