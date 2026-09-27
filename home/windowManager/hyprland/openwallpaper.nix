{
  config,
  host,
  lib,
  pkgs,
  settings,
  ...
}: let
  enabledScenes = settings.openwallpaper.enabled;
  selectedScene = host.openwallpaper.selected;
  sceneNames = builtins.attrNames (builtins.readDir ./openwallpaper/scenes);
  apiHeader = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/mechakotik/openwallpaper/e854dbbcb9e39f6927aca85f06685008da536350/include/openwallpaper.h";
    hash = "sha256-fxIAm5zfZl0R6wvTdeh+pZsv0cKK7jyvNKqoC7y2ppc=";
  };
  sceneSource = name: ./openwallpaper/scenes + "/${name}";
  sceneFiles = name: let
    source = sceneSource name;
  in
    ["scene.wasm" "metadata.ndl"]
    ++ lib.optional (builtins.pathExists (source + "/vertex.glsl")) "vertex.spv"
    ++ lib.optional (builtins.pathExists (source + "/fragment.glsl")) "fragment.spv";
  buildScene = name: let
    source = sceneSource name;
    hasVertexShader = builtins.pathExists (source + "/vertex.glsl");
    hasFragmentShader = builtins.pathExists (source + "/fragment.glsl");
  in
    pkgs.pkgsCross.wasi32.stdenv.mkDerivation {
      pname = "openwallpaper-scene-${name}";
      version = "1";
      src = source;
      nativeBuildInputs = lib.optionals (hasVertexShader || hasFragmentShader) [pkgs.shaderc];
      dontConfigure = true;
      buildPhase = ''
        runHook preBuild
        cp ${apiHeader} openwallpaper.h
        $CC -I. \
          -mexec-model=reactor -Wl,--allow-undefined -O2 \
          scene.c -o scene.wasm
        ${lib.optionalString hasVertexShader "glslc -fshader-stage=vertex vertex.glsl -o vertex.spv"}
        ${lib.optionalString hasFragmentShader "glslc -fshader-stage=fragment fragment.glsl -o fragment.spv"}
        runHook postBuild
      '';
      installPhase = ''
        runHook preInstall
        mkdir -p "$out"
        cp ${lib.concatStringsSep " " (sceneFiles name)} "$out/"
        runHook postInstall
      '';
    };
  scenes = lib.genAttrs enabledScenes buildScene;
  dataDirectory = "${config.home.homeDirectory}/.local/share/owui/local";
  shortcut = "${config.home.homeDirectory}/Pictures/OpenWallpaper";
  settingsPath = "${config.xdg.configHome}/owui/settings.ndl";
  defaultSettings = pkgs.writeText "openwallpaper-default-settings.ndl" ''
    prefer_discrete_gpu false
    pause_hidden true
    pause_on_bat ${lib.boolToString host.hyprland.battery}
    vsync false
    fps_limit 30
    audio_visualization true
    audio_backend 0
    audio_source ""
    video_scale_mode "aspect-crop"
    video_filter ""
    steam_library_path ""
    autorun_wallpapers {}
  '';
  openwallpaper = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "openwallpaper-bin";
    version = "unstable-2026-09-27";

    # Upstream publishes an unversioned archive; the hash pins this snapshot.
    src = pkgs.fetchurl {
      url = "https://openwallpaper.org/openwallpaper-linux-amd64.tar.xz";
      hash = "sha256-kzzGbfRFvBF9tNtpvNmLFV/zxR40QMwhCFul7MOCK6o=";
    };

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      wrapGAppsHook4
    ];
    buildInputs =
      (with pkgs; [
        libadwaita
        gtk4
        pango
        harfbuzz
        gdk-pixbuf
        cairo
        graphene
        glib
        gobject-introspection
        vulkan-loader
      ])
      ++ finalAttrs.runtimeDependencies;
    # wallpaperd loads its video, audio and Wayland backends with dlopen.
    runtimeDependencies = map pkgs.lib.getLib (with pkgs; [
      mpv-unwrapped
      wayland
      pipewire
      libpulseaudio
      portaudio
      vulkan-loader
      libGL
      libxkbcommon
      libdecor
      libdrm
      mesa
      udev
      alsa-lib
      libjack2
      libXScrnSaver
      libXtst
    ]);
    # Optional backends from the bundled SDL are unused for Wayland wallpapers.
    autoPatchelfIgnoreMissingDeps = [
      "libopenxr_loader.so.1"
      "libsteam_api.so"
      "libGLES_CM.so.1"
      "libsndio.so.7"
      "libvkd3d-utils.so.1"
    ];

    dontConfigure = true;
    dontBuild = true;
    installPhase = ''
      runHook preInstall
      mkdir -p "$out"
      cp -r bin share "$out/"
      runHook postInstall
    '';
    preFixup = ''
      gappsWrapperArgs+=(--prefix PATH : "$out/bin:${pkgs.lib.makeBinPath [pkgs.shaderc]}")
    '';

    meta = {
      description = "Live wallpaper runtime with a GTK interface and Wallpaper Engine support";
      homepage = "https://github.com/mechakotik/openwallpaper";
      license = pkgs.lib.licenses.gpl3Only;
      platforms = ["x86_64-linux"];
      mainProgram = "owui";
    };
  });
in {
  assertions = [
    {
      assertion = lib.all (name: builtins.elem name sceneNames) enabledScenes;
      message = "OpenWallpaper settings.openwallpaper.enabled contains a name without a matching scenes directory";
    }
    {
      assertion = selectedScene == null || builtins.elem selectedScene enabledScenes;
      message = "OpenWallpaper host.openwallpaper.selected must be null or an enabled scene name";
    }
  ];

  home.packages = [openwallpaper];

  home.activation.openWallpaperData = lib.hm.dag.entryAfter ["linkGeneration"] ''
    run mkdir -p ${lib.escapeShellArg dataDirectory}
    # WASI cannot follow Home Manager links that escape the scene directory,
    # so install real copies of compiled modules and assets.
    ${lib.concatMapStringsSep "\n" (name: ''
        run mkdir -p ${lib.escapeShellArg "${dataDirectory}/${name}"}
        ${lib.concatMapStringsSep "\n" (file: ''
          run cp --remove-destination ${lib.escapeShellArg "${scenes.${name}}/${file}"} ${lib.escapeShellArg "${dataDirectory}/${name}/${file}"}
        '') (sceneFiles name)}
      '')
      enabledScenes}
    if [ ! -e ${lib.escapeShellArg shortcut} ] && [ ! -L ${lib.escapeShellArg shortcut} ]; then
      run ln -s ${lib.escapeShellArg dataDirectory} ${lib.escapeShellArg shortcut}
    fi
    if [ ! -e ${lib.escapeShellArg settingsPath} ]; then
      run mkdir -p ${lib.escapeShellArg (builtins.dirOf settingsPath)}
      run cp ${defaultSettings} ${lib.escapeShellArg settingsPath}
      run chmod u+w ${lib.escapeShellArg settingsPath}
    fi
  '';

  systemd.user.services.openwallpaper = lib.mkIf (selectedScene != null) {
    Unit = {
      Description = "Selected OpenWallpaper scene";
      PartOf = ["hyprland-session.target"];
    };
    Service = {
      WorkingDirectory = "${dataDirectory}/${selectedScene}";
      ExecStart = "${openwallpaper}/bin/wallpaperd --pause-hidden ${lib.optionalString host.hyprland.battery "--pause-on-bat"} ${dataDirectory}/${selectedScene}/scene.wasm";
      Restart = "on-failure";
    };
    Install.WantedBy = ["hyprland-session.target"];
  };
}
