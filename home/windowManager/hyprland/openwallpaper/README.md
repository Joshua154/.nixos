# OpenWallpaper scenes

The scene source and selection live here so they stay with the Hyprland NixOS
configuration. `scenes/solid`, `scenes/pulse`, and `scenes/fullscreen-shader`
are working examples. The `templates` folder is a starting point for another
C scene.

To add a scene:

1. Copy `templates` to `scenes/<name>` and edit `scene.c` and `metadata.ndl`.
2. Add `<name>` to `openwallpaper.enabled` in the repository's root
   `settings.nix`.
3. Rebuild the host. Nix compiles `scene.c` to `scene.wasm` and places it with
   `metadata.ndl` in `~/.local/share/owui/local/<name>/`. If the scene has
   `vertex.glsl` or `fragment.glsl`, Nix also compiles and installs the shader.

OpenWallpaper UI (`owui`) lists every enabled scene. To start one automatically
with Hyprland, set `hosts.<hostname>.openwallpaper.selected = "<name>";` in
the root `settings.nix` and rebuild. `selected = null;` keeps the existing
Waypaper background on that host. When a scene is selected, its Hyprland
session runs it through a user service and does not start Waypaper's background
service.

For personal wallpapers outside Git, add a subfolder to
`~/Pictures/OpenWallpaper`. It points to OpenWallpaper's local library. A
scene folder needs `scene.wasm`; a video folder can contain `video.mp4`.
OpenWallpaper scans these folders when its UI starts.

The scene C API comes from the pinned
[OpenWallpaper header](https://github.com/mechakotik/openwallpaper/blob/e854dbbcb9e39f6927aca85f06685008da536350/include/openwallpaper.h).
The fullscreen shader scene is adapted from the pinned
[upstream example](https://github.com/mechakotik/openwallpaper/tree/e854dbbcb9e39f6927aca85f06685008da536350/examples/fullscreen-shader),
which credits the original shader to XorDev.
