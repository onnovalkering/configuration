{ lib, fetchurl }:

{ username }:

let
  url = "https://github.com/${username}.keys";
  keys = lib.filter (x: x != "" && x != [ ]) (
    builtins.split "\n" (
      builtins.readFile (fetchurl {
        url = url;
      })
    )
  );
in
keys