{ config, pkgs, ... }:

let
  gitConfig = ''
    [user]
      name = "leo.habets";
      email = "leo.habets@epita.fr";

    [includeIf "gitdir:${config.home.homeDirectory}/FORGE"]
      path = "${config.home.homeDirectory}/.gitconfig-forge";
  '';
in {
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
      k = "kubectl";
    };
  };

  programs.git = {
    enable = true;
  };
  home.file.".gitconfig".text = gitConfig;

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
      gruvbox-nvim
      nvim-treesitter.withAllGrammars
      nvim-lspconfig
      nvim-cmp
      luasnip
    ];
  };
}
