{ pkgs }:
let
  buildSwiftScript =
    name:
    pkgs.runCommand name { } ''
      mkdir -p $out/bin

      /Library/Developer/CommandLineTools/usr/bin/swiftc \
        -sdk /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk \
        ${./${name}.swift} \
        -o $out/bin/${name}
    '';
in
{
  usb-watcher = buildSwiftScript "usb-watcher";
}
