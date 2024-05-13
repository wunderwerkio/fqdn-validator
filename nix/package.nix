{
  pkgs,
  rustPlatform,
  ...
}: let
  pname = "fqdn-validator";
  version = "git";
in
  rustPlatform.buildRustPackage {
    inherit pname version;

    src = pkgs.lib.cleanSourceWith {
      filter = name: type: let
        baseName = baseNameOf (toString name);
      in
        ! (pkgs.lib.hasSuffix ".nix" baseName);
      src = pkgs.lib.cleanSource ../.;
    };

    cargoLock = {
      lockFile = ../Cargo.lock;
    };

    nativeBuildInputs = with pkgs; [
      openssh
      pkg-config
    ];

    buildInputs = with pkgs; [
      openssl
    ];

    doCheck = false;

    cargoHash = "sha256-R4d+zUalDOpx7bRREzny7OHLBQzArl1mcW5dwt8qyEM=";
  }


