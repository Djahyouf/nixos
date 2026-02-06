{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration-t480s.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-d5656370-4e4e-4d1d-b004-13750e44dad2".device = "/dev/disk/by-uuid/d5656370-4e4e-4d1d-b004-13750e44dad2";

  networking.hostName = "leo-t480s";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.autorun = true;
  services.xserver.windowManager.i3.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "leo";

  # ---
  # GISTRE specific VHDL
  services.udev.packages = [ pkgs.usb-blaster-udev-rules ];
  # ---

  # ---
  # GISTRE specific IOT
  services = {
    node-red = {
      enable = true;
      openFirewall = true;
      withNpmAndGcc = true;
    };
    mosquitto.enable = true;
  };
  # ---

  # ---
  # GISTRE specific VIRT
  # Docker
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    enableOnBoot = false;
  };

  # Libvirtd
  programs.virt-manager.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    onBoot = "ignore";
    qemu = {
      swtpm.enable = true;
    };
  };
  # ---

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

  nix.settings.auto-optimise-store = true;
  environment.systemPackages = with pkgs; [
    vim
    wget

    # ---
    # GISTRE specific VHDL
    # Serial
    screen
    picocom
    minicom

    # Embedded
    arduino
    arduino-cli
    arduino-ide
    saleae-logic-2

    # Elec
    kicad
    # ---
  ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
  nixpkgs.config.allowUnfree = true;
}

