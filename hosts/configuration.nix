{ config, lib, pkgs, inputs, user, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

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
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  security.polkit.enable = true; # required to setup sway with HomeManager

  services = {
    xserver = {
      enable = true;
      libinput.enable = true; # enable touchpad
      desktopManager = {
        xterm.enable = false;
      };
      # windowManager.xmonad.enable = true;
      layout = "us,de";
      xkbOptions = "caps:ctrl_modifier";
      #   "eurosign:e"
      #   "shift:both_capslock"
      # };
    };

    blueman.enable = true;

    openssh.enable = true;
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
    '';
  };

  sound = {
    enable = true;
    mediaKeys = {
      enable = true;
    };
  };

  hardware.pulseaudio.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "camera"
      "networkManager"
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
      vim
      neovim
      tmux
      git
      curl
      wget
      httpie
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
