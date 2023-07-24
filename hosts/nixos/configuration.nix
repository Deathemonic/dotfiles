{ lib, config, pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
  };

  networking = {
    hostName = "nixos";
    useDHCP = lib.mkDefault true;
  };

  time = {
    timeZone = "Asia/Manila";
    hardwareClockInLocalTime = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings.LC_TIME = "en_PH.UTF-8";

    supportedLocales = [
      "en_US.UTF-8/UTF-8"
      "en_PH.UTF-8/UTF-8"
    ];
  };

  hardware = {
    pulseaudio.enable = false;

    bluetooth = {
      enable = true;
      package = pkgs.bluezFull;
    };

    opengl = {
      enable = true;
      extraPackages = [ pkgs.mesa ];
      driSupport32Bit = true;
      extraPackages32 = [ pkgs.pkgsi686Linux.mesa ];
    };
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    curl
    wget
    btop
    killall
  ];

  system.stateVersion = "23.11";
}
