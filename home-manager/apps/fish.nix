
 { 
  # Enable and configure fish
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      echo Hello friend!
      echo The time is (set_color yellow; date +%T; set_color normal) and this machine is called $hostname      
    '';
  };
}
