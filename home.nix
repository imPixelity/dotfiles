{ config, pkgs, ... }:
{
  home.username = "photon";
  home.homeDirectory = "/home/photon";
  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    nnn # terminal file manager

    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processor https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg
    gcc

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

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
}
