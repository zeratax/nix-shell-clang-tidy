{ pkgs ? import <nixpkgs> {}, clangVersion ? 17 }:
let
  llvmPackages = pkgs."llvmPackages_${toString clangVersion}";
  customSystemc = (pkgs.systemc.override {
    stdenv = llvmPackages.libcxxStdenv;
  }).overrideAttrs (oldAttrs: {
    CXXFLAGS = [ "-std=c++20" ];
  });
in
(pkgs.mkShell.override { stdenv = llvmPackages.libcxxStdenv; }) {
  buildInputs = [
    pkgs.bear
    pkgs.clang-tools
  ];

  shellHook = ''
    export CXXFLAGS="-isystem${llvmPackages.libcxx.dev}/include/c++/v1"
    export SYSTEMC_HOME=${customSystemc}
  '';
}

