This repository contains the NixOS & home-manager configuration for my desktop.

## Setup

To use this repository as base configuration for my desktop running:

### NixOS Linux

### Manual NixOS Installation
  - Enable Wifi
  ```sh-session
  $ sudo -i
  $ systemctl start wpa_supplicant
  $ wpa_cli
  $ add_network
  $ set_network 0 ssid "myhomenetwork"
  $ set_network 0 psk "mypassword"
  $ set_network 0 key_mgmt WPA-PSK
  $ enable_network 0
  $ quit
  ```
  - Partitions
  ```sh-session
  $ parted
  $ select /dev/sda
  $ mklabel gpt
  $ mkpart primary 512MB -8GB
  $ mkpart primary linux-swap -8GB 100%
  $ mkpart ESP fat32 1MB 512MB
  $ set 3 esp on
  ```
  - Formatting
  ```sh-session
  $ mkfs.ext4 -L nixos /dev/sda1
  $ mkswap -L swap /dev/sda2
  $ mkfs.fat -F 32 -n boot /dev/sda3
  ```

  - Installation
  ```sh-session
  $ mount /dev/disk/by-label/nixos /mnt
  $ mkdir -p /mnt/boot
  $ mount /dev/disk/by-label/boot /mnt/boot
  $ swapon /dev/sda2
  $ nixos-generate-config --root /mnt
  $ nano /mnt/etc/nixos/configuration.nix
  ```
  Uncomment the following line to enable NetworkManager
  ```sh-session
  # networking.networkmanager.enable = true;
  ```
  Add git to packages
  ```sh-session
  environment.systemPackages = with pkgs; [
    git
  ];
  ```
### Configuration
  - Connect to wifi via nmcli
  ```sh-session
  $ nmcli device wifi connect "myhomenetwork" --ask
  ```
  - Clone repo
  ```sh-session
  $ git clone https://github.com/ricardoaranaga/nix-config.git
  ```
  - Copy configuration.nix to /etc/nixos/
  ```sh-session
  $ sudo cp nix-config/configuration.nix /etc/nixos/
  ```
  - Rebuild system
  ```sh-session
  $ nixos-rebuild switch
  ```
  - Prepare initial Home Manager configuration
  ```sh-session
  $ nix run home-manager/master -- init --switch
  ```
  - Replace home.nix and add the 'apps' folder to .config/home-manager/
  ```sh-session
  $ cp nix-config/home-manager/* ~/.config/home-manager/
  ```
  - Build config files with home-manager
  ```sh-session
  $ home-manager switch
  ```

### Reboot

### Directory layout

- `home-manager`: home-manager config
- `configuration.nix`: nixos modules and inital packages

## To free up disk space,

   ```sh-session
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    sudo nixos-rebuild boot
    ```
