{ pkgs ? import (builtins.fetchTarball {
  url =
    # Tue Feb 27 10:37:18 AM CET 2024
    "https://github.com/NixOS/nixpkgs/archive/5bf1cadb72ab4e77cb0b700dab76bcdaf88f706b.tar.gz";
}) { } }:
pkgs.mkShell {
  nativeBuildInputs = with pkgs; [ cabal-install dotnet-sdk_8 fantomas ];
}
