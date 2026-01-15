from libqtile import bar, widget
from libqtile.config import Screen
from libqtile.backend.wayland import Output

# Define outputs
outputs = [
    Output("DP-7", primary=True, width=1920, height=1200, x=0, y=0, scale=1),
    Output("DP-8", primary=False, width=1920, height=1200, x=1920, y=0, scale=1),
    Output("eDP-1", primary=False, width=1920, height=1200, x=3840, y=0, scale=1),
]

# Define Qtile screens (bars etc.)
screens = [
    Screen(top=bar.Bar([widget.GroupBox(), widget.WindowName()], 24)),
    Screen(top=bar.Bar([widget.GroupBox(), widget.WindowName()], 24)),
    Screen(top=bar.Bar([widget.GroupBox(), widget.WindowName()], 24)),
]
