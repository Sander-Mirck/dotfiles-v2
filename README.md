# NixOS dotfiles – v2 (Flake-based)

This repository contains my NixOS configuration, built with **flakes**.  
It sets up a complete desktop environment (XFCE) with a clean, modular structure.

## 📁 Structure

- `configuration.nix` – main system configuration
- `hardware-configuration.nix` – hardware-specific (auto-generated)
- `packages.nix` – central list of system-wide packages
- `flake.nix` – flake definition
- `flake.lock` – version lock file (commit it!)

## 🚀 Usage

### 1. Clone (on a new machine)

```
git clone git@github.com:Sander-Mirck/dotfiles-v2.git /home/sander/nixos
cd /home/sander/nixos
```

### 2. Build and switch

```
sudo nixos-rebuild switch --flake .#nixos
```

### 3. Optional alias

Add to your `~/.bashrc` or `~/.zshrc`:

```
alias nr='sudo nixos-rebuild switch --flake /home/sander/nixos#nixos'
```

Then run `nr` from anywhere to rebuild.

## 📦 Packages

All system packages are managed centrally in `packages.nix`.  
Highlights:

- **Browser**: `librewolf` (privacy-focused)
- **Essentials**: `git`, `vim`, `wget`, `curl`, `btop`, `tree`, `ncdu`, `fd`, `ripgrep`, `nix-index`, etc.

Add new packages by editing `packages.nix` (inside the `with pkgs; [ ... ]` list).

## 📜 License

MIT – see `LICENSE` for details.

---

*Made with ❤️ by Sander Mirck*
```
