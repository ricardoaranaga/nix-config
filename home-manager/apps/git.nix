{
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
  };
}
