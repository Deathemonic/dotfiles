{ lib, pkgs, inputs, outputs, ... }: {
  imports = [
    ./system
    ./packages
  ] ++ ( builtins.attrValues outputs.nixosModules );

  nixpkgs = {
    overlays = [ outputs.overlays.default ];
    config.allowUnfree = true;
  };
}
