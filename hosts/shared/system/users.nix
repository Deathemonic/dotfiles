{ config, pkgs, ...  }: let
  ifTheyExist = groups: builtins.filter ( group: builtins.hasAttr group config.users.groups ) groups;
in {
  users.users.zinth = {
    description = "Zinth Anisem";
    isNormalUser = true;
    uid = 1000;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "input"
    ] ++ ifTheyExist [
      "network"
      "networkmanager"
      "git"
    ];
  };
}