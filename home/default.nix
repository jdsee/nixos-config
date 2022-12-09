{ config, lib, pkgs, user, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ./alacritty
    ./git
    ./i3
    ./keyd
    ./nvim
    ./polybar
    ./shell
    ./tmux
  ];

  home = {

    username = "${user}";
    homeDirectory = "/home/${user}";
    stateVersion = "22.05";

    packages = with pkgs; [
      thunderbird
      signal-desktop

      docker
      exa
      fd
      file
      fortune
      gnupg
      htop-vim
      httpie
      jq
      lxappearance
      nitrogen
      pamixer
      ranger
      ripgrep
      unzip
      xdotool

      clang
      clojure
      gnumake
      leiningen
      python3

      # gammastep
      # grim
      # imv
      # mako
      # slurp
      # sway-contrib.grimshot
      # swayidle
      # swaylock
      # wl-clipboard
      # wofi
      # xwayland
    ];

    sessionVariables = {
      # XDG_SESSION_TYPE = "wayland";
      # XDG_SESSION_DESKTOP = "sway";
      # XDG_CURRENT_DESKTOP = "sway";
      # SDL_VIDEODRIVER = "wayland";
      # GDK_BACKEND = "wayland";
      # QT_QPA_PLATFORM = "wayland";
      # BMENU_BACKEND = "wayland";
      # QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      # _JAVA_AWT_WM_NONPARENTING = 1;
      # MOZ_ENABLE_WAYLAND = 1;
      # MOZ_DBUS_REMOTE = 1;
      # MOZ_USE_XINPUT2 = 1;
    };
  };

  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      vim-surround
    ];
    settings = {
      number = true;
      relativenumber = true;
      ignorecase = true;
      hidden = true;
      tabstop = 2;
      expandtab = true;
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      forceWayland = true;
      extraPolicies = {
        ExtensionSettings = { };
      };
    };
    # TODO: install NUR
    # extensions = with pkgs.nur.repos.rycee.firefox-addons; [
    #   cookie-autodelete
    #   darkreader
    #   bitwarden
    #   ublock-origin
    #   tridactyl
    # ];
  };

  programs.zathura = {
    enable = true;
    options = {
      font = "monospace normal 16";
      incremental-search = true;
    };
    # TODO
    extraConfig = ''
      include $HOME/setup/hosts/config/zathura/zathura-gruvbox/zathura-gruvbox-dark
    '';
  };

  xsession = {
    enable = true;
  };

  # TODO
  # xdg.configFile = {
  #   wofi = {
  #     source = ./wofi/config/wofi;
  #     recursive = true;
  #   };
  # };

  # home.file.".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../themes/wall;

}
