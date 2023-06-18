This repository contains the NixOS & home-manager configuration for my desktop.

## Setup

To use this repository as base configuration for my desktop running:

### NixOS Linux

- Manual NixOS Installation
  - Enable Wifi
  ```shell
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
  ```shell
  $ parted
  $ select /dev/sda
  $ mklabel gpt
  $ mkpart primary 512MB -8GB
  $ mkpart primary linux-swap -8GB 100%
  $ mkpart ESP fat32 1MB 512MB
  $ set 3 esp on
  ```
  - Formatting
  ```shell
  $ mkfs.ext4 -L nixos /dev/sda1
  $ mkswap -L swap /dev/sda2
  $ mkfs.fat -F 32 -n boot /dev/sda3
  ```

  - Installation
  ```shell
  $ mount /dev/disk/by-label/nixos /mnt
  $ mkdir -p /mnt/boot
  $ mount /dev/disk/by-label/boot /mnt/boot
  $ swapon /dev/sda2
  $ nixos-generate-config --root /mnt
  $ nano /mnt/etc/nixos/configuration.nix
  ```
  - Uncomment the following line to enable NetworkManager
  ```shell
  # networking.networkmanager.enable = true;
  ```
  - Add git to packages
  ```shell
  environment.systemPackages = with pkgs; [
    git
  ];
  ``` 
- Configuration
  - Connect to wifi via nmcli
  ```shell
  nmcli device wifi connect "myhomenetwork" --ask
  ```  
  - Clone repo 
  ```shell
  $ git clone https://github.com/ricardoaranaga/nix-config.git
  ```
  - Copy configuration.nix to /etc/nixos/
  ```shell
  $ sudo cp nix-config/configuration.nix /etc/nixos/
  ```
  - Rebuild system
  ```shell
  $ nixos-rebuild switch
  ```
  - Prepare initial Home Manager configuration
  ```shell
  $ nix run home-manager/master -- init --switch
  ```
  - Replace home.nix and add the 'apps' folder to .config/home-manager/
  ```shell
  $ cp nix-config/home-manager/* ~/.config/home-manager/
  ```
  - Build config files with home-manager
  ```shell
  $ home-manager switch
  ```
- Reboot

### Directory layout 

- `home-manager`: home-manager config
- `configuration.nix`: nixos modules and inital packages

## Tips

- To free up disk space,
    ```sh-session
    sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +2
    sudo nixos-rebuild boot
    ```
- To autoformat the project tree using nixpkgs-fmt, run `nix fmt`.
