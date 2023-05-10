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

  # Enable Sway
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    config = rec {
      modifier = "Mod4";
      # Use alacritty as default terminal
      terminal = "alacritty"; 
      startup = [
        # Launch Firefox on start
        {command = "firefox";}
      ];
      bars = [{ command = "waybar"; }];
    };
  };

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

  # Waybar
  programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      style = ''
              * {
                font-family: "JetBrainsMono Nerd Font";
                font-size: 12pt;
                font-weight: bold;
                border-radius: 0px;
                transition-property: background-color;
                transition-duration: 0.5s;
              }
              @keyframes blink_red {
                to {
                  background-color: rgb(242, 143, 173);
                  color: rgb(26, 24, 38);
                }
              }
              .warning, .critical, .urgent {
                animation-name: blink_red;
                animation-duration: 1s;
                animation-timing-function: linear;
                animation-iteration-count: infinite;
                animation-direction: alternate;
              }
              window#waybar {
                background-color: transparent;
              }
              window > box {
                margin-left: 5px;
                margin-right: 5px;
                margin-top: 5px;
                background-color: rgb(30, 30, 46);
              }
        #workspaces {
                padding-left: 0px;
                padding-right: 4px;
              }
        #workspaces button {
                padding-top: 5px;
                padding-bottom: 5px;
                padding-left: 1px;
                padding-right: 1px;
              }
        #workspaces button.focused {
                background-color: rgb(181, 232, 224);
                color: rgb(26, 24, 38);
              }
        #workspaces button.urgent {
                color: rgb(26, 24, 38);
              }
        #workspaces button:hover {
                background-color: rgb(248, 189, 150);
                color: rgb(26, 24, 38);
              }
              tooltip {
                background: rgb(48, 45, 65);
              }
              tooltip label {
                color: rgb(217, 224, 238);
              }
        #custom-launcher {
                font-size: 20px;
                padding-left: 8px;
                padding-right: 6px;
                color: #7ebae4;
              }
        #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
                padding-left: 10px;
                padding-right: 10px;
              }
              /* #mode { */
              /* 	margin-left: 10px; */
              /* 	background-color: rgb(248, 189, 150); */
              /*     color: rgb(26, 24, 38); */
              /* } */
        #memory {
                color: rgb(181, 232, 224);
              }
        #cpu {
                color: rgb(245, 194, 231);
              }
        #clock {
                color: rgb(217, 224, 238);
              }
        /*#idle_inhibitor {
                color: rgb(221, 182, 242);
              }*/ 
        #custom-wall {
                 color: rgb(221, 182, 242);
            }
        #temperature {
                color: rgb(150, 205, 251);
              }
        #backlight {
                color: rgb(248, 189, 150);
              }
        #pulseaudio {
                color: rgb(245, 224, 220);
              }
        #network {
                color: #ABE9B3;
              }
        #network.disconnected {
                color: rgb(255, 255, 255);
              }
        #battery.charging, #battery.full, #battery.discharging {
                color: rgb(250, 227, 176);
              }
        #battery.critical:not(.charging) {
                color: rgb(242, 143, 173);
              }
        #custom-powermenu {
                color: rgb(242, 143, 173);
              }
        #tray {
                padding-right: 8px;
                padding-left: 10px;
              }
        #mpd.paused {
                color: #414868;
                font-style: italic;
              }
        #mpd.stopped {
                background: transparent;
              }
        #mpd {
                color: #c0caf5;
              }
        #custom-cava-internal{
                font-family: "Hack Nerd Font" ;
              }
      '';
      settings = [{
        modules-left = [
          "custom/launcher"
          "sway/workspaces"
          "temperature"
          #"idle_inhibitor"
          "custom/wall"
          "mpd"
          "custom/cava-internal"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "network"
          "battery"
          "custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill rofi || ~/.config/rofi/launcher.sh";
          "tooltip" = false;
        };
        "custom/wall" = {
          "on-click" = "wallpaper_random";
          "on-click-middle" = "default_wall";
          "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
          "format" = " ﴔ ";
          "tooltip" = false;
        };
        "custom/cava-internal" = {
          "exec" = "cava-internal";
          "tooltip" = false;
        };
        "sway/workspaces" = {
          "disable-scroll" = true;
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = "{icon} {percent}%";
          "format-icons" = [ "" "" "" "" ];
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "婢 Muted";
          "format-icons" = {
            "default" = [ "" "" "" ];
          };
          "states" = {
            "warning" = 85;
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "battery" = {
          "interval" = 10;
          "states" = {
            "warning" = 20;
            "critical" = 10;
          };
          "format" = "{icon} {capacity}%";
          "format-icons" = [ "" "" "" "" "" "" "" "" "" ];
          "format-full" = "{icon} {capacity}%";
          "format-charging" = " {capacity}%";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          /* "tooltip-format"= "{=%A; %d %B %Y}\n<tt>{calendar}</tt>" */
          "tooltip-format" = "上午：高数\n下午：Ps\n晚上：Golang\n<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "﬙ {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = " {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty ncmpcpp";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "interval" = 1;
          "format-wifi" = "說 {essid}";
          "format-ethernet" = "  {ifname} ({ipaddr})";
          "format-linked" = "說 {essid} (No IP)";
          "format-disconnected" = "說 Disconnected";
          "tooltip" = false;
        };
        "temperature" = {
          # "hwmon-path"= "${env:HWMON_PATH}";
          #"critical-threshold"= 80;
          "tooltip" = false;
          "format" = " {temperatureC}°C";
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
      }];
    };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "22.11";
}
