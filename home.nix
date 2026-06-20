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
      gg = "cd /home/photon/.config/nixsail";
    };
  };

  programs.vim = {
    enable = true;
    extraConfig = ''
      set tabstop=2
      set shiftwidth=2
      set softtabstop=2
      set expandtab
    '';
  };

  programs.firefox.enable = true;
  programs.waybar.enable = true;

  xdg.configFile."fastfetch" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/photon/.config/nixsail/config/fastfetch;
    recursive = true;
  };

  xdg.configFile."niri" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/photon/.config/nixsail/config/niri;
    recursive = true;
  };

  home.packages = with pkgs; [
    gcc
  ];
}
