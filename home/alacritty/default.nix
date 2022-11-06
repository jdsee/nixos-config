{ config, lib, pkgs, user, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "alacritty";
      window = {
        decorations = "none";
        title = "Alacritty";
      };
    };
  };
}
