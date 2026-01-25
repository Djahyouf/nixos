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
      nrs = "cd ~/NixOs; sudo nixos-rebuild switch --flake .";
      grep = "grep --color=auto";
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
