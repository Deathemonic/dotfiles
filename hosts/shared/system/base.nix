{pkgs, lib, config, inputs, ...}: {
  console = let
    normal = [
      "161a1e"
      "e5a3a1"
      "b4e3ad"
      "ece3b1"
      "a3cbe7"
      "ceace8"
      "c9d4ff"
      "eeeff0"
    ];
    bright = [
      "43474b"
      "f9b7b5"
      "c8f7c1"
      "fff7c5"
      "b7dffb"
      "e2c0fc"
      "dde8ff"
      "f8f9fa"
    ];
  in {
    colors = normal ++ bright;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u16n.psf.gz";
    useXkbConfig = true;
  };

  documentation = {
    enable = true;
    doc.enable = false;
    man.enable = true;
    dev.enable = false;
  };

  nix = {
    settings = {
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      trusted-users = [
        "root"
        "@wheel"
      ];

      auto-optimise-store = true;
      builders-use-substitutes = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      flake-registry = "/etc/nix/registry.json";
      keep-derivations = true;
      keep-outputs = true;
      max-jobs = "auto";
      warn-dirty = false;
    };

    package = pkgs.nixUnstable;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };

    registry = lib.mapAttrs ( _: value: { flake = value; } ) inputs;

    nixPath = lib.mapAttrsToList ( key: value: "${key}=${value.to.path}" ) config.nix.registry;
  };
}