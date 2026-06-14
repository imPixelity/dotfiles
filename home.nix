{ config, pkgs, ... }:

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

  xdg.configFile."fastfetch" = {
    source = config.lib.file.mkOutOfStoreSymlink "/home/photon/.config/nixsail/config/fastfetch";
    recursive = true;
  };

  home.packages = with pkgs; [
    gcc
  ];
}
