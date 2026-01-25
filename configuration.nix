{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration-t480s.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "leo-t480s";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.windowManager.i3.enable = true;
  services.displayManager.sddm.enable = true;

  users.users.leo = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      # command line tools :
      tree
      feh
      git
      lazygit
      lsd
      bat
      ripgrep
      fzf
      jq

      # terminal emulators :
      alacritty

      # text editors / integrated developpment environement :
      neovim

      # utilities :
      keepassxc

      # other :
      rofi
    ];
  };

  programs.firefox.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}

