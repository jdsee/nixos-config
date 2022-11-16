{ config, lib, pkgs, inputs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../modules/kmonad.nix
  ];

  nixpkgs = {
    config = {
      allowBroken = true;
      allowUnfree = true;
    };
    overlays = [
      (import (builtins.fetchTarball {
        url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
        sha256 = "1aby5aswd8f0965bz761jm3sananl3id1yi2kmlxj2p4ckqlq4f8";
      }))
    ];
  };

  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5;
    };
    efi.canTouchEfiVariables = true;
    timeout = 1;
  };

  networking = {
    hostName = "t14_jdsee";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Amsterdam";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  security = {
    polkit.enable = true; # required to setup sway with HomeManager
    pam.services.swaylock = {
      text = "auth include login";
    };
  };

  services = {
    xserver = {
      enable = true;
      libinput = {
        enable = true; # enable touchpad
        touchpad = {
          disableWhileTyping = false;
          naturalScrolling = true;
        };
      };
      desktopManager = {
        xterm.enable = false;
      };
      videoDrivers = [
        "displaylink"
        "modsetting"
      ];
      displayManager = {
        sessionCommands = ''
          ${lib.getBin pkgs.xorg.xrandr}/bin/xrandr --setprovideroutputsource 2 0
        '';
      };
      # windowManager.xmonad.enable = true;
      layout = "us,de";
      xkbOptions = "caps:ctrl_modifier,shift:both_capslock";
    };

    # greetd = {
    #   enable = true;
    #   settings = rec {
    #     initial_session = {
    #       command = "${pkgs.sway}/bin/sway";
    #       user = "${user}";
    #     };
    #     default_session = initial_session;
    #   };
    # };

      kmonad = {
        # TODO
        enable = false;
        # configfiles = [ ../home/kmonad/config.kbd ];
      };

      blueman.enable = true;
      openssh.enable = true;
    };

    systemd.services = {
      keyd = {
        description = "key remapping daemon";
        requires = [ "local-fs.target" ];
        after = [ "local-fs.target" ];
        wantedBy = [ "sysinit.target" ];
        unitConfig = {
          Type = "simple";
        };
        serviceConfig = {
          ExecStart = "/usr/bin/keyd";
        };
      };
    };

    environment.etc = {
      "keyd/default.conf".source = ../home/keyd/config/keyd/default.conf;
    };

    fonts.fonts = with pkgs; [
      font-awesome
      (nerdfonts.override {
        fonts = [
          "Hack"
        ];
      })
    ];

    nix = {
      settings.auto-optimise-store = true;
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
      package = pkgs.nixFlakes;
      registry.nixpkgs.flake = inputs.nixpkgs;
      extraOptions = ''
        experimental-features = nix-command flakes
        warn-dirty = false
      '';
    };

    sound = {
      enable = true;
      mediaKeys = {
        enable = true;
      };
    };

    hardware = {
      pulseaudio.enable = true;
      opengl = {
        enable = true;
        driSupport = true;
      };
    };

    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };
    };

    users.users.${user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "video"
        "audio"
        "camera"
        "networkManager"
        "input"
        "uinput"
      ];
      shell = pkgs.zsh;
      packages = with pkgs; [
      ];
    };

    environment = {
      variables = {
        TERMINAL = "alacritty";
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
      systemPackages = with pkgs; [
        tmux
        git
        curl
        wget

        ((vim_configurable.override { }).customize {
          name = "vim";
          vimrcConfig = {
            packages.myplugins = with pkgs.vimPlugins; {
              start = [ vim-nix vim-lastplace ];
              opt = [ ];
            };
            customRC = ''
              set nu
              set relativenu
              set incsearch
              set nocompatible
              backspace=indent,eol,start
              syntax on
            '';
          };
        })
      ];
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    programs = {
      light.enable = true;
      sway.enable = true;
    };

    system.stateVersion = "22.05";
  }
