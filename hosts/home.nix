{ config, lib, pkgs, user, ... }:

{
  programs.home-manager.enable = true;

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    stateVersion = "22.05";
  
    packages = with pkgs; [
      # GUI
      alacritty
      firefox
      thunderbird
      signal-desktop

      # CLI
      fzf
      gnupg
      htop-vim
      unzip
      # znap
      zoxide
    ];
  };

  xsession = {
    enable = true;
  };

  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "Alacritty";
      startup = [
        { command = "alacritty"; }
      ];
    };
  };

  # home.file.".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../themes/wall;

}
