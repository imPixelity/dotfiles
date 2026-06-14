{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sail";
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Jakarta";

  users.users.photon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;
  programs.niri.enable = true;
  programs.waybar.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${config.programs.niri.package}/bin/niri-session";
        user = "photon";
      };
    };
  };

  security.polkit.enable = true;
  security.pam.services.swaylock = { };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    neovim
    ghostty
    alacritty
    fuzzel
    swaylock
    mako
    swayidle
    fastfetch
  ];

  system.stateVersion = "26.05";

}
