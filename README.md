# dotfiles

my hyprland, sway, awesome and i3 configs for nixos.

### Install nix

- enable flakes

  - in _`configuration.nix`_ add
    ```nix
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    ```
  - `# nixos-rebuild switch`

- `# nixos-rebuild switch --flake github:sachnr/dotfiles#desktop`

### wsl2

- enable _`Virtual Machine Platform`_ and _`Windows Subsystem for Linux`_
- download latest release from [here](https://github.com/nix-community/NixOS-WSL/releases)
- `wsl --import NixOS nixos-wsl-installer.tar.gz --version 2`
- `wsl -d NixOS`
- in nixos `nixos-rebuild switch --flake github:sachnr/dotfiles#wsl`
