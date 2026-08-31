
# NixOS dotfiles – v2

Flake-based NixOS configuration with XFCE as the desktop environment.

## Structure

- `configuration.nix` – main system configuration
- `hardware-configuration.nix` – auto-generated hardware configuration
- `packages.nix` – central list of system packages
- `neovim.nix` – Neovim configuration
- `flake.nix` – flake definition
- `flake.lock` – lockfile for reproducible builds

## Usage

Clone the repository and build the system:

```bash
git clone git@github.com:Sander-Mirck/dotfiles-v2.git /home/sander/nixos
cd /home/sander/nixos
sudo nixos-rebuild switch --flake .#nixos
```

Optional alias for `~/.bashrc` or `~/.zshrc`:

```bash
alias nr='sudo nixos-rebuild switch --flake /home/sander/nixos#nixos'
```

## Customization

- System options: `configuration.nix`
- Packages: `packages.nix`
- Neovim: `neovim.nix`

Run `nr` after making changes to rebuild the configuration.

## License

MIT – see `LICENSE`.
