# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A multi-host Nix flake managing NixOS and macOS (nix-darwin) system configs plus home-manager
user configs for a single user (`mox`), across 6 hosts:

- **NixOS** (`nixosConfigurations`): `nixos-fusion` (aarch64, VMware VM), `beau` (aarch64, Apple Silicon via
  `nixos-apple-silicon`), `intel-mac` (x86_64, T2 Mac via `nixos-hardware`), `nox` (x86_64, Nvidia desktop/gaming
  rig), `vm-workstation` (x86_64).
- **macOS** (`darwinConfigurations`): `sandy` (aarch64-darwin, via nix-darwin + nix-homebrew).

## Common commands

Build/switch a NixOS host (run on that host):
```
sudo nixos-rebuild switch --flake .#<hostname>
```

Build/switch the macOS host (run on `sandy`):
```
darwin-rebuild switch --flake .#sandy
```

Dry-build without activating (useful for checking a config evaluates/builds on any machine):
```
nix build .#nixosConfigurations.<hostname>.config.system.build.toplevel --dry-run
nix build .#darwinConfigurations.sandy.system --dry-run
```

Check flake syntax/evaluation across all outputs:
```
nix flake check
```

Format Nix files (formatter available via home packages, `nixfmt`/`alejandra`):
```
nixfmt **/*.nix
```

Lint for dead code / anti-patterns (`statix` and `deadnix` are included as home packages):
```
statix check .
deadnix .
```

Update all flake inputs:
```
nix flake update
```
Update a single input:
```
nix flake lock --update-input <input-name>
```

There are no tests in this repo; correctness is validated by building/switching a config.

## Architecture

**Layering**: every host's `configuration.nix` imports hardware-specific config plus one or more shared
modules from `modules/`, which fan out to per-user home-manager configs in `home/`.

```
flake.nix
  └─ hosts/<host>/configuration.nix   (host-specific: hostname, bootloader, drivers, hardware quirks)
       ├─ hosts/<host>/hardware-configuration.nix   (generated, NixOS only — don't hand-edit)
       ├─ modules/common.nix          (shared across ALL hosts, Linux + Darwin)
       ├─ modules/linuxcommon.nix     (shared across all NixOS hosts: locale, greetd, 1Password, fonts)
       │    OR modules/darwincommon.nix  (shared across all Darwin hosts: homebrew, macOS defaults, aerospace)
       └─ home-manager.users.mox → home/linux.nix  OR  home/darwin.nix
            └─ home/default.nix       (shared across Linux + Darwin: shell tools, git, neovim, ssh, zsh)
                 └─ home/<tool>.nix   (one file per program: hyprland.nix, waybar.nix, ghostty.nix, etc.)
```

Key points when adding or editing config:
- `modules/common.nix` is the base for literally every machine (NixOS and Darwin) — put only things that
  are truly universal there.
- `modules/linuxcommon.nix` vs `modules/darwincommon.nix` is the OS-level fork; host `configuration.nix`
  files import exactly one of these plus `common.nix`.
- `home/default.nix` is the home-manager equivalent fork point — `home/linux.nix` and `home/darwin.nix`
  both import it, then layer OS-specific home-manager modules (e.g. `hyprland.nix`/`waybar.nix`/`niri.nix`
  on Linux, nothing extra needed on Darwin beyond `home/default.nix`).
- Linux hosts using Hyprland/niri as the window manager wire their home-manager modules through
  `home/linux.nix`, which imports `home/hyprland.nix`, `home/niri.nix`, `home/waybar.nix`, `home/rofi.nix`,
  `home/dunst.nix`, `home/hypridle.nix`, `home/hyprlock.nix`, `home/chromium.nix`, `home/gaming.nix`.
- All flake inputs are pinned via `inputs.<name>.follows = "nixpkgs"` where applicable to avoid duplicate
  nixpkgs evaluations — keep that pattern when adding new inputs that themselves depend on nixpkgs.
- `specialArgs = { inherit inputs; }` is passed to every host, and `home-manager.extraSpecialArgs = { inherit inputs; }`
  to every home-manager config, so any module can reference `inputs.<flakeInput>` directly (e.g.
  `home/default.nix` imports `inputs.lazyvim.homeManagerModules.default`). Hyprland itself comes from nixpkgs
  (`programs.hyprland` in `modules/linuxcommon.nix`), not a flake input; don't pin a pre-0.55 build (it leaks
  the NixOS wrapper's CAP_SYS_NICE to launched apps and breaks bwrap/Steam).
- Hardware-configuration files (`hosts/*/hardware-configuration.nix`) and `hosts/beau/apple-silicon-support`
  / `hosts/beau/firmware` are machine-generated/vendor artifacts — avoid hand-editing unless intentionally
  re-running the hardware detection.
- nix-darwin's `sandy` host is the only Darwin target and layers `nix-homebrew` for Homebrew tap/package
  management declared in `hosts/sandy/configuration.nix` (brews/casks/taps), not in `home/`.
