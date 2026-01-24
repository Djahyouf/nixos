{ config, pkgs, ... }:

{
  home.username = "leo";
  home.homeDirectory = "/home/leo";
  home.stateVersion = "25.11";

  programs.bash = {
    enable = true;
    shellAliases = {
      ".." = "cd ..";
      vi = "nvim";
    };
  };

  programs.git = { 
    enable = true;
    settings = {
      user = {
        name = "leo.habets";
        email = "leo.habets@epita.fr";
      };
    };
  };
}
