{theme, ...}: let
  c = theme.colors;
in {
  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun,run,window";
      show-icons: true;
      drun-display-format: "{name}";
      display-drun: "Applications";
    }

    * {
      background: #${c.background};
      background-alt: #${c.surface};
      foreground: #${c.foreground};
      selected: #${c.accent};
      border: #${c.overlay};
    }

    window {
      width: 38%;
      border: 2px;
      border-color: @selected;
      border-radius: 12px;
      background-color: @background;
    }

    mainbox { padding: 18px; spacing: 10px; }
    inputbar { padding: 10px; border-radius: 8px; background-color: @background-alt; }
    listview { lines: 8; columns: 1; spacing: 5px; }
    element { padding: 9px; border-radius: 8px; }
    element selected { background-color: @selected; text-color: @background; }
    element-text { text-color: inherit; }
  '';
}
