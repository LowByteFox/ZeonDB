{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
        cmake
        ninja
        pkg-config
        libuv
        libressl
    ];
}
