{ pkgs, ... }: {
  security = {
    polkit.enable = true;
    rtkit.enable = true;

    apparmor = {
      enable = true;
      killUnconfinedConfinables = true;
      packages = [ pkgs.apparmor-profiles ];
    };

    pam = {
      loginLimits = [
        {
          domain = "@wheel";
          item = "nofile";
          type = "soft";
          value = "524288";
        }
        {
          domain = "@wheel";
          item = "nofile";
          type = "hard";
          value = "1048576";
        }
      ];

      services = {
        login.enableGnomeKeyring = true;
      };
    };

    sudo = {
      extraConfig = ''
        Defaults !tty_tickets
        Defaults insults
        Defaults pwfeedback
        Defaults timestamp_timeout=15
        Defaults timestamp_type=global
      '';
    };
  };
}
