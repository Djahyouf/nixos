{ config, pkgs, ... }:

{
  home.username = "leo";
  home.homeDirectory = "/home/leo";
  home.stateVersion = "25.11";

  # i3 config file
  home.file."${config.home.homeDirectory}/.config/i3/config" = {
    source = ./i3/config;
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
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

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [
      plenary-nvim
      nui-nvim
      neo-tree-nvim
      fzf-lua
      nvim-web-devicons
      bufferline-nvim
    ];
  };
}
