# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ inputs, lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    # ./git.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  # TODO: Set your username
  home = {
    username = "raranaga";
    homeDirectory = "/home/raranaga";
  };

  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  home.packages = with pkgs; [ 
    steam
    neofetch 
  ];

  # Enable home-manager
  programs.home-manager.enable = true;

  # Enable and configure git
  programs.git = {
    enable = true;
    userName = "ricardoaranaga";
    userEmail = "ricardo.aranaga@gmail.com";
    aliases = {
      co = "checkout";
      ci = "commit";
      cia = "commit --amend";
      s = "status";
      st = "status";
      b = "branch";
      # p = "pull --rebase";
      pu = "push";
    };
    ignores = [ "*~" "*.swp" ];
    extraConfig = {
      core.editor = "nvim";
      pull.rebase = "false";
    };
  };

  # Enable and configure starship
  programs.starship = {
    enable = true;
    settings = {
      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "🌐 ";
        format = "on [$hostname](bold red) ";
        trim_at = ".local";
        disabled = false;
      };
    };
  };
  
  # Enable and configure fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      echo Hello friend!
      echo The time is (set_color yellow; date +%T; set_color normal) and this machine is called $hostname      
    '';
  };

  # Enable and configure alacritty
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };

      window_opacity = 0.95;

      window = {
        padding.x = 10;
        padding.y = 10;
        #decorations = "buttonless";
      };

      font = {
        size = 12.0;
        #normal.family = "FuraCode Nerd Font";
        #bold.family = "FuraCode Nerd Font";
        #italic.family = "FuraCode Nerd Font";
      };

      cursor.style = "Beam";

      shell = {
        program = "fish";
        args = [
          "-C"
          "neofetch"
        ];
      };

      colors = {
        # Default colors
        primary = {
	background = "0x1b182c";
	foreground = "0xcbe3e7";
      };

	# Normal colors
	normal = {
	   black =   "0x100e23";
	   red =     "0xff8080";
	   green =   "0x95ffa4";
	   yellow =  "0xffe9aa";
	   blue =    "0x91ddff";
	   magenta = "0xc991e1";
	   cyan =    "0xaaffe4";
	   white =   "0xcbe3e7";
	};

	# Bright colors
	bright = {
	   black =   "0x565575";
	   red =     "0xff5458";
	   green =   "0x62d196";
	   yellow =  "0xffb378";
	   blue =    "0x65b2ff";
	   magenta = "0x906cff";
	   cyan =    "0x63f2f1";
	   white = "0xa6b3cc";
	};
      };
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
