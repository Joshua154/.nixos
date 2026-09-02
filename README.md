# NixOS configuration

A modular, multi-host NixOS flake. Shared system modules live in `modules/system`, selectable hardware and desktop profiles live in `modules/profiles`, and Home Manager configuration lives in `home`.

## Private configuration

Identity, machine hardware, host profiles, monitor layouts, firewall ports, shares, and peer identifiers belong in `config/private.nix`. Git ignores that file.

```sh
install -m 600 config/private.example.nix config/private.nix
$EDITOR config/private.nix
```

Use a `path:` flake reference locally. A normal Git flake source excludes ignored files, while `path:` includes the private overlay:

```sh
nix flake check "path:$PWD"
sudo nixos-rebuild switch --flake "path:$PWD#my-host"
```

The public flake remains evaluable without the overlay, but exposes no host configurations. The `rebuild` shell alias assumes the checkout is at `~/.nixos` and uses the current host automatically.

Do not store passwords, API keys, tunnel tokens, or private keys in any Nix expression. Nix copies evaluated source files into the world-readable Nix store. Store credentials outside the repository and reference a protected credential file, as the Cloudflare module does.

## Layout

- `config/default.nix`: public, privacy-safe defaults
- `config/private.example.nix`: documented private configuration schema
- `settings.nix`: merges defaults with the optional private overlay
- `hosts/default.nix`: data-driven machine hardware module
- `modules/profiles`: selectable boot, hardware, networking, desktop, and program modules
- `modules/system`: shared and optional service modules
- `home`: Home Manager programs, shell, desktop, and theme configuration
- `benchmark`: optional benchmark development shell and runner

## Maintenance

```sh
nix fmt
nix flake check "path:$PWD"
nix develop "path:$PWD#benchmark"
```
