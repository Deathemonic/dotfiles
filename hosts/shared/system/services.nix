{ lib, pkgs, ... }: {
  services = {
    blueman.enable = true;
    udisks2.enable = true;
    fstrim.enable = true;
    fwupd.enable = true;
    gvfs.enable = true;
    ntp.enable = true;
    mpd.enable = true;

    udev.packages = [ pkgs.gnome.gnome-settings-daemon ];

    dbus = {
      enable = true;
      packages = with pkgs; [ dconf gcr ];
    };

    gnome = {
      glib-networking.enable = true;
      gnome-keyring.enable = true;
    };

    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = lib.mkForce false;
        PermitRootLogin = lib.mkForce "no";
      };
    };

    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;

      alsa = {
        enable = true;
	      support32Bit = true;
      };
    };
  };

  systemd.user.services = {
    NetworkManager-wait-online.enable = false;

    pipewire.wantedBy = [ "default.target" ];
    pipewire-pulse = {
      path = [ pkgs.pulseaudio ];
      wantedBy = [ "default.target" ];
    };
  };
}
