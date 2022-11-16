{ config, lib, pkgs, user, ... }:

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;

    style = ./style.css;

    settings = [{
      height = 20;
      layer = "top";

      modules-left = [
        "sway/workspaces"
      ];

      modules-center = [
        "clock"
      ];

      modules-right = [
        "sway/language"
        "network"
        "battery"
      ];

      "sway/workspaces" = {
        all-outputs = false;
        disable-scroll = true;
        format = "{icon} {name}";
        format-icons = {
          "1:www" = "龜";
          "2:mail" = "";
          "3:editor" = "";
          "4:terminals" = "";
          "5:portal" = "";
          urgent = "";
          focused = "";
          default = "";
        };
      };

      battery = {
        interval = 10;
        states = {
          warning = 30;
          critical = 1;
        };
        format = "  {icon}  {capacity}%";
        format-discharging = "{icon}  {capacity}%";
        format-icons = [
          ""
            ""
            ""
            ""
            ""
        ];
        tooltip = true;
      };

      network = {
        interval = 5;
        format-wifi = " 直";
        format-ethernet = " ";
        format-disconnected = "";
        format-alt = ''{essid}: {ipaddr} | {bandwidthUpBits} "" {bandwidthDownBits} ""'';
        tooltip = false;
      };

      "sway/language" = {
        format = "  {long}";
        tooltip = false;
      };

    }];
  };
}
