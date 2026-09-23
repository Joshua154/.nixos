{
  lib,
  pkgs,
}: let
  # Use the official binary while retaining nixpkgs' Java/Minecraft wrapper.
  pandoraBinary = lib.makeOverridable (
    {msaClientID ? null}:
      assert lib.assertMsg (msaClientID == null) "The Pandora binary uses the upstream Microsoft client ID";
        pkgs.stdenv.mkDerivation rec {
          pname = "pandora-launcher-bin";
          version = "6.0.0";
          src = pkgs.fetchurl {
            url = "https://github.com/Moulberry/PandoraLauncher/releases/download/v${version}/PandoraLauncher-Linux-x86_64_${version}_amd64.deb";
            hash = "sha256-E6DboIlGtjcWmy70LUENY4w67lTRRn5pFHRySsnAcwI=";
          };

          nativeBuildInputs = [
            pkgs.autoPatchelfHook
            pkgs.dpkg
          ];
          buildInputs = with pkgs; [
            stdenv.cc.cc.lib
            libxcb
            libxkbcommon
            udev
            libseccomp
            openssl
          ];
          runtimeDependencies = map lib.getLib (
            with pkgs; [
              alsa-lib
              dbus
              fontconfig
              libGL
              vulkan-loader
              wayland
            ]
          );

          unpackPhase = ''
            runHook preUnpack
            dpkg-deb -x "$src" .
            runHook postUnpack
          '';
          dontConfigure = true;
          dontBuild = true;
          installPhase = ''
            runHook preInstall
            mkdir -p "$out"
            cp -r usr/bin usr/share "$out/"
            mv "$out/bin/PandoraLauncher-Linux-x86_64" "$out/bin/pandora_launcher"
            substituteInPlace "$out/share/applications/PandoraLauncher-Linux-x86_64.desktop" \
              --replace-fail "Exec=PandoraLauncher-Linux-x86_64" "Exec=pandora_launcher"
            runHook postInstall
          '';
          doInstallCheck = true;
          installCheckPhase = ''
            runHook preInstallCheck
            "$out/bin/pandora_launcher" --help
            runHook postInstallCheck
          '';
          meta =
            pkgs.pandora-launcher-unwrapped.meta
            // {
              platforms = ["x86_64-linux"];
            };
        }
  ) {};
in
  pkgs.pandora-launcher.override {
    pandora-launcher-unwrapped = pandoraBinary;
  }
