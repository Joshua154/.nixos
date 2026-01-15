{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      # normal fonts
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      newcomputermodern

      # nerdfonts
      nerd-fonts.fira-code
      nerd-fonts.jetbrains-mono
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = [
        "Noto Serif"
        "Noto Color Emoji"
      ];
      sansSerif = [
        "Noto Sans"
        "Noto Color Emoji"
      ];
      monospace = [
        "JetBrainsMono Nerd Font"
        "Noto Color Emoji"
      ];
      emoji = ["Noto Color Emoji"];
    };
  };
}
