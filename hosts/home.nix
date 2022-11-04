{ config, lib, pkgs, user, ... }:

{
  programs.home-manager.enable = true;

    imports = [
      ./config/zsh.nix
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
      file
      fortune
      fzf
      gnumake
      gnupg
      htop-vim
      httpie
      jq
      tmuxinator
      unzip
      ripgrep

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
      waybar
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

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    zplug = {
      enable = true;
      plugins = [
      { name = "sindresorhus/pure"; }
      { name = "zsh-users/zsh-autosuggestions"; }
      { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
    sessionVariables = {
      GPG_TTY = "$(tty)";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      PURE_NODE_ENABLED = 0;
      PURE_CMD_MAX_EXEC_TIME = 0;
      FZF_TMUX = 0;
      FZF_CTRL_T_OPTS = "--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'";
      FZF_CTRL_R_OPTS = "--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'";
      FZF_ALT_C_OPTS = "--preview 'tree -C {} | head -200'";
    };
    interactiveShellInit = ''
      eval "$(ssh-agent)" >/dev/null
      eval "$( pyenv init - --no-rehash )"
      eval "$( pyenv virtualenv-init - )"
      eval "$( pip completion --zsh )"
      '';
    shellAliases = {
      vi = "nvim";
      vind = "nvim -c 'Telescope zoxide list'";

      ls = "exa";
      ll = "ls -Alh";
      la = "ls -A";
      ld = "ls -Ad";
      tree = "la --tree";
      trees = "tree --depth 4";

      ".." = "cd ../";
      "..." = "cd ../../";
      "...." = "cd ../../../";
      "....." = "cd ../../../../";
      "......" = "cd ../../../../../";

      lg = "lazygit";
      rmgi = "git rm -r --cached . && git add . && git status";
      conflicts = "grep -lr '<<<<<<<' .";

      _ = "sudo";
      cat = "bat -p";
      grep = "grep --color";
      hg = "history 0 | grep";
      mycolors = "msgcat --color=test";
      view = "zathura";
      diff = "colordiff";
      clip = "xclip -sel clip";

      "src.zsh" = "source $HOME/.zshrc";
      "src.aliases" = "source $HOME/.config/zsh/aliases.zsh";

      "set.zsh" = "nvim $HOME/.zshrc";
      "set.env" = "nvim $HOME/.zshenv";
      "set.aliases" = "nvim $HOME/.config/zsh/aliases.zsh";
      "set.functions" = "nvim $HOME/.config/zsh/functions.zsh";
      "set.completion" = "nvim $HOME/.config/zsh/completion.zsh";
      "set.nvim" = "nvim $HOME/.config/nvim/init.lua";

      tx = "tmuxinator";
      mux = "tx me";

      update = "sudo nixos-rebuild switch --flake .#jdsee";
    };
    history = {
      size = 100000;
      save = 1000000;
      share = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd j"
    ];
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
      tabwidth = 2;
      expandtab = true;
    };
  };

  programs.neovim = {
    enable = true;
  };

  programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "jdsee";
    userEmail = "jdsee@protonmail.com";
    extraConfig = {
      core.editor = "vim";
    };
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    shortcut = "f";
    terminal = "screen-256color";
    clock24 = true;
    escapeTime = 1;
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

  xsession = {
    enable = true;
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
        fonts.size = 12.0;
#command = "waybar";
        position = "top";
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
