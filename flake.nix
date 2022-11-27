{
  description = "name_your_package_nix";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShells.default = pkgs.stdenv.mkDerivation {
            name = "devshell__NAME_YOUR_PACKAGE";
            buildInputs = [
              pkgs.rustup
              pkgs.rust-analyzer
              pkgs.nixpkgs-fmt
            ] ++ (
              if pkgs.stdenv.isDarwin then [
                pkgs.darwin.apple_sdk.frameworks.Security
                pkgs.darwin.apple_sdk.frameworks.SystemConfiguration
                pkgs.libiconv
              ] else if pkgs.stdenv.isLinux then [
              ] else [ ]
            );
          };
        }
      );
}




