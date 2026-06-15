{ config, pkgs, ... }:
let
  dotfiles = "${config.home.homeDirectory}/.config/nixsail/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configs = {
    fastfetch = "fastfetch";
  };
in
{
  home.username = "photon";
  home.homeDirectory = "/home/photon";
  home.stateVersion = "26.05";

  programs.git = {
    enable = true;
    settings.user.name = "photon";
    settings.user.email = "dzikrynp14@gmail.com";
    settings.init.defaultBranch = "main";
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ff = "fastfetch";
    };
  };

  # home.file.".config/fastfetch".source = ./config/fastfetch;

  /*
    xdg.configFile."fastfetch" = {
      # source = config.lib.file.mkOutOfStoreSymlink "/home/photon/.config/nixsail/config/fastfetch";
      source = create_symlink "${dotfiles}/fastfetch";
      recursive = true;
    };
  */

  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
  }) configs;

  home.packages = with pkgs; [
    gcc
  ];
}
