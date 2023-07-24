{ lib, pkgs, ... }: {
  environment = with pkgs; {
    binsh = "${pkgs.dash}/bin/dash";
    shells = [ zsh ];
    pathsToLink = [ "/share/zsh" ];

    loginShellInit = ''
      dbus-update-activation-environment --all
      eval $(gnome-keyring-daemon --start --daemonize --components=pkcs11,secrets,ssh)
      eval $(ssh-agent)
    '';

    variables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      JDK_JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djdk.gtk.version=2.2 -Dsun.java2d.opengl=true";
      SUDO_PROMPT = "$(tput setaf 1 bold)Password:$(tput sgr0) ";
    };
  };
}
