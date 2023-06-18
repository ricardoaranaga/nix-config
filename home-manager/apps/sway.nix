{
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
}
