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
    description = "my user";
    extraGroups = [
      "wheel"
      "networkManager"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKwxH01Zdjfsi47PzAOIepxMOLbiYZRY53VcHeJn7ge7 photon@sail"
    ];
    packages = with pkgs; [
      tree
    ];
  };

  programs.niri.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
    openFirewall = true;
  };

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

  environment.variables.EDITOR = "vim";

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
    noctalia-shell
    sqlite
  ];

  system.stateVersion = "26.05";

}
