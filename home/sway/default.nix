{ config, lib, pkgs, user, ... }:

{
  wayland.windowManager.sway = {
    enable = false;
    package = null;
    xwayland = true;
    systemdIntegration = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };

    config = rec {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "wofi --show run --gtk-dark";

      # output = {
      #   "HDMI1" = "pos 0 0";
      #   "INTERNAL" = "pos 2560 0";
      # };

      gaps = {
        inner = 5;
        outer = 5;
        smartGaps = true;
        smartBorders = "on";
      };

      assigns = {
        "2" = [{ class = "alacritty"; }];
        "3" = [{ class = "Firefox"; }];
        "4" = [{ class = "Signal"; }];
        "5" = [{ class = "Thunderbird"; }];
      };

      bars = [ ];

      output = {
        eDP-1 = {
          scale = "1";
        };
      };

      startup = [
        { command = "mako"; }
        { command = "alacritty"; }
        {
          command =
            let
              lockCmd = "'swaylock -f -i ~/Wallpapers/reunion-lake.jpg'";
            in
            ''swayidle -w \
          timeout 600 ${lockCmd} \
          timeout 1200 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
          before-sleep ${lockCmd}
        '';
        }
      ];

      keybindings =
        let
          mod = config.wayland.windowManager.sway.config.modifier;
          inherit (config.wayland.windowManager.sway.config)
            left down up right menu terminal;
        in
        {
          "${mod}+Return" = "exec ${terminal}";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec ${menu}";

          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";

          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";

          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          "${mod}+Shift+space" = "floating toggle";

          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          "${mod}+p" =
            "exec ${pkgs.slurp}/bin/slurp | ${pkgs.grim}/bin/grim -g- screenshot-$(date +%Y%m%d-%H%M%S).png";

          # "${mod}+h" = "split ;
          "${mod}+v" = "split v";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+comma" = "layout stacking";
          "${mod}+period" = "layout tabbed";
          "${mod}+slash" = "layout toggle split";
          "${mod}+a" = "focus parent";
          "${mod}+s" = "focus child";

          "${mod}+r" = "mode resize";

          # "${mod}+Control+q" = ''exec ${pkgs.swaylock}/bin/swaylock -f -i ~/Wallpapers/reunion-lake.jpg'';
          "${mod}+m" = "exec ${pkgs.mako}/bin/makoctl dismiss";
          "${mod}+Shift+m" = "exec ${pkgs.mako}/bin/makoctl dismiss -a";

          "${mod}+apostrophe" = "move workspace to output right";

          "${mod}+minus" = "scratchpad show";
          "${mod}+underscore" = "move container to scratchpad";

          "${mod}+Space" = "exec ${menu}";

          "${modifier}+w" = "kill";

          "${modifier}+Control+j" = "resize shrink height 20 px";
          "${modifier}+Control+k" = "resize grow height 20 px";

          "${modifier}+Control+h" = "workspace prev";
          "${modifier}+Control+l" = "workspace next";

          # "${modifier}+r" = "mode resize";

          "XF86AudioLowerVolume" = "exec ${pkgs.pamixer}/bin/pamixer -d 10";
          "XF86AudioLowerVolume+Shift" = "exec ${pkgs.pamixer}/bin/pamixer -d 10 --allow-boost";
          "XF86AudioRaiseVolume" = "exec ${pkgs.pamixer}/bin/pamixer -i 10";
          "XF86AudioRaiseVolume+Shift" = "exec ${pkgs.pamixer}/bin/pamixer -i 10 --allow-boost";
          "XF86AudioMute" = "exec ${pkgs.pamixer}/bin/pamixer -t";

          "XF86MonBrightnessDown" = "exec ${pkgs.light}/bin/light -U 10";
          "XF86MonBrightnessUp" = "exec ${pkgs.light}/bin/light -A 10";

          "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
          "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
          "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";
        };

      input = {
        "type:touchpad" = {
          tap = "enabled";
          dwt = "enabled";
          scroll_method = "two_finger";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
        };
        "type:pointer" = {
          natural_scroll = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "us,de";
          xkb_options = "grp:alt_space_toggle,altwin:swap_alt_win";
        };
      };

    };
  };
}
