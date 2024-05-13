{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    rust-overlay,
  } @ inputs: {
    nixosModules= {
      default = import ./nix/module.nix inputs;
    };
  } // flake-utils.lib.eachDefaultSystem (system:
    let
      overlays = [
        (import rust-overlay)
      ];
      pkgs = import nixpkgs {
        inherit system overlays;
      };
      rustToolchain = ./rust-toolchain.toml;
      libPath = pkgs.lib.makeLibraryPath [ pkgs.openssl ];
      rust = (pkgs.rust-bin.fromRustupToolchainFile rustToolchain);

      rustPlatform = pkgs.makeRustPlatform {
        cargo = rust;
        rustc = rust;
      };

      fqdn-validator = import ./nix/package.nix {
        inherit pkgs rustPlatform;
      };
    in {
      defaultPackage = fqdn-validator;

      packages = {
        inherit fqdn-validator;
        default = fqdn-validator;
      };

      devShells = rec {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            pkg-config
            rust
          ];

          buildInputs = with pkgs; [];
        };

      };

      formatter = pkgs.alejandra;
    }
  );
}
