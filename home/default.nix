{ config, lib, pkgs, user, ... }:

let
  big = text: "<span font='17' rise='-3000'>" + text + "</span>";
in {
  programs.home-manager.enable = true;

  imports = [
    ./alacritty
    ./git
    ./nvim
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

      bat
      docker
      exa
      fd
      file
      fortune
      gnumake
      gnupg
      htop-vim
      httpie
      jq
      pamixer
      ranger
      ripgrep
      unzip

      gammastep
      grim
      imv
      mako
      slurp
      sway-contrib.grimshot
      swayidle
      swaylock
      wl-clipboard
      wofi
      xwayland
    ];

    sessionVariables = {
      XDG_SESSION_TYPE = "wayland";
      XDG_SESSION_DESKTOP = "sway";
      XDG_CURRENT_DESKTOP = "sway";
      SDL_VIDEODRIVER = "wayland";
      GDK_BACKEND = "wayland";
      QT_QPA_PLATFORM = "wayland";
      BMENU_BACKEND = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = 1;
      _JAVA_AWT_WM_NONPARENTING = 1;
      MOZ_ENABLE_WAYLAND = 1;
      MOZ_DBUS_REMOTE = 1;
      MOZ_USE_XINPUT2 = 1;
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
        ExtensionSettings = {};
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

  programs.waybar = {
    enable = true;
    # style = ./config/waybar/style.css;
    settings = [{
      height = 20;
      layer = "top";

      modules-left = [
        "sway/workspaces"
        "sway/window"
      ];

      modules-center = [
      ];

      modules-right = [
        "network"
        "battery"
        "clock"
      ];

      "sway/workspaces" = {
        format-icons = {
          "1" = "";
          "2" = "";
          "3" = "";
          "4" = "";
          "5" = "";
          "6" = "";
          "7" = "";
          "8" = "";
          "9" = "ﭮ";
          "urgent" = "";
          "focused" = "";
          "default" = "";
        };
      };

      battery = {
        interval = 60;
        bat = "BAT1";
        format = ''{capacity}% ${big "{icon}"}'';
        format-alt = ''${big " {icon}"}'';
        format-icons = [ "" "" "" "" "" ];
        tooltip = false;

        states = {
          runAndGetTheCharger = 20;
          prepareToRun = 40;
          tisGoinLow = 60;
        };
      };

      network = {
        interval = 5;
        format-wifi = ''${big " 直"}'';
        format-ethernet = ''${big " "}'';
        format-disconnected = ''${big ""}'';
        format-alt = ''{essid}: {ipaddr} | {bandwidthUpBits} ${big ""} {bandwidthDownBits} ${big ""}'';
        tooltip = false;
      };

    }];
  };

  wayland.windowManager.sway = {
    enable = true;
    package = null;
    xwayland = true;
    systemdIntegration = true;
    wrapperFeatures = {
      base = true;
      gtk = true;
    };

    config = rec {
      modifier = "Mod1";
      terminal = "alacritty";
      menu = "wofi --show run";

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

      bars = [{
        command = "waybar";
      }];

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
# lockCmd = "'swaylock -f -i \"\$(${wallpaper}/bin/wallpaper get)\"'";
          lockCmd = "'swaylock -f'";
        in
          ''swayidle -w \
          timeout 600 ${lockCmd} \
          timeout 1200 'swaymsg "output * dpms off"' \
          resume 'swaymsg "output * dpms on"' \
          before-sleep ${lockCmd}
        '';
      }
      ];

      keybindings = lib.mkOptionDefault {

        "Mod4+Space" = "exec wofi --show run";

        "${modifier}+Shift+r" = "reload";
        "${modifier}+w" = "kill";

        "${modifier}+Control+j" = "resize shrink height 20 px";
        "${modifier}+Control+k" = "resize grow height 20 px";

        "${modifier}+Control+h" = "workspace prev";
        "${modifier}+Control+l" = "workspace next";

        "${modifier}+r" = "mode resize";

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
          xkb_options = "caps:ctrl_modifier,grp:ctrl_space_toggle";
        };
      };

    };
  };

# home.file.".config/wall".source = config.lib.file.mkOutOfStoreSymlink ../themes/wall;

}
