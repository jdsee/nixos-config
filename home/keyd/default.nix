{ config, lib, pkgs, user, ... }:

{
  home.file."/etc/keyd/default.conf" = {
    source = ./config/keyd;
    recursive = true;
  };
}
