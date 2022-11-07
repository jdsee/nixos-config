{ config, lib, pkgs, user, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "jdsee";
    userEmail = "jdsee@protonmail.com";
    extraConfig = {
      core.editor = "vim";
    };
  };
}
