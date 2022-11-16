{ config, lib, pkgs, user, ... }:

{
  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "jdsee";
    userEmail = "jdsee@protonmail.com";
    extraConfig = {
      core.editor = "nvim";
      color.ui = true;
      init.defaultBranch = "main";
      pull = {
        # TODO: rebase
        ff = "only";
      };
    };
    ignores = [
      ".DS_Store"
      "*.pyc"
    ];
    delta = {
      enable = true;
      options = {
        navigate = true;
        line-numbers = true;
        syntax-theme = "DarkNeon";
      };
    };
  };
}
