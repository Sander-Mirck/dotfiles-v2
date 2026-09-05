# dotfiles-v2

NixOS 25.05 flake — XFCE + Nord + TLP.

## Structure
- `configuration.nix` — system, desktop, power
- `packages.nix` — system packages
- `neovim.nix` — nvim + nord
- `hardware-configuration.nix` — generated, don't edit
- `flake.nix` — inputs

## Quick start
```bash
git clone git@github.com:Sander-Mirck/dotfiles-v2.git ~/nixos
cd ~/nixos
sudo nixos-rebuild switch --flake .#nixos
```

## Usage
```bash
# after changes
git add -A && sudo nixos-rebuild switch --flake .#nixos

# update all inputs
nix flake update
```

Alias (`~/.zshrc`):
```bash
alias nr='sudo nixos-rebuild switch --flake ~/nixos#nixos'
```


## License
MIT
