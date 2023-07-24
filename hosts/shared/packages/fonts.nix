{ pkgs, ... }: {
  fonts = {
    fonts = with pkgs; [
      jetbrains-mono
      material-symbols
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      roboto-slab
      roboto-serif
      sarasa-gothic

      ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; } )
    ];

    fontconfig = {
      enable = true;
      antialias = true;
      hinting = {
        enable = true;
        autohint = true;
        style = "full";
      };

      subpixel.lcdfilter = "default";

      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "JetBrains Mono" ];
        sansSerif = [ "Roboto" ];
        serif = [ "Roboto Serif" ];
      };
    };
  };
}