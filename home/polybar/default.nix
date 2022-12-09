{ config, lib, pkgs, user, ... }:

{
  services.polybar = {
    enable = true;
    script = "polybar bar &";
    settings = {
      "bar" = { };

      "module/xkeyboard" = {
        type = "internal/xkeyboard";
        blacklist = [ "num lock" ];

        label.layout = "%layout%";
        # label.layout.foreground = "${colors.alert}";

        label.indicator.padding = 2;
        label.indicator.margin = 1;
        # label.indicator.foreground = "${colors.background}";
        # label.indicator.background = "${colors.secondary}";
      };
    };
  };

  xdg.configFile = {
    "polybar/config.ini" = {
      source = ./config.ini;
      recursive = true;
    };
  };

}
