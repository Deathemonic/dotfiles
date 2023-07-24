{ pkgs, config, ... }: let
  core = import ./core.nix { pkgs = pkgs; };
  dev = import ./dev.nix { pkgs = pkgs; };
  etc = import ./etc.nix { pkgs = pkgs; };
  utilities = import ./utilities.nix { pkgs = pkgs; };
in {
  imports = [ ./fonts.nix ];
  environment.systemPackages = with pkgs; [ ]
  ++ core
  ++ dev
  ++ etc
  ++ utilities;
}