{ config, lib, pkgs, user, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    defaultKeymap = "emacs";

    zplug = {
      enable = true;
      plugins = [
        { name = "mafredri/zsh-async"; }
        { name = "sindresorhus/pure"; }
      ];
    };

    history = {
      size = 100000;
      save = 1000000;
      share = true;
      expireDuplicatesFirst = true;
      ignoreSpace = true;
    };

    sessionVariables = {
      GPG_TTY = "$(tty)";
      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      PURE_NODE_ENABLED = 0;
      PURE_CMD_MAX_EXEC_TIME = 0;
    };

    initExtra = ''
      eval "$(ssh-agent)" >/dev/null
      # eval "$( pyenv init - --no-rehash )"
      # eval "$( pyenv virtualenv-init - )"
      # eval "$( pip completion --zsh )"

      source ~/.config/zsh/popman.sh
      zle -N popman

      bindkey  popman
      bindkey '^O' autosuggest-accept
    '';

    shellAliases = {
      vind = "nvim -c 'Telescope zoxide list'";

      ls = "exa";
      ll = "ls -alh";
      la = "ls -a";
      ld = "ls -ad";
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

      tx = "tmuxinator";
      mux = "tx me";

      update = "sudo nixos-rebuild switch --flake .#jdsee";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    tmux.enableShellIntegration = false;
  };

  programs.bat = {
    enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [
      "--cmd j"
    ];
  };

  xdg.configFile.zsh = {
    source = ./config/zsh;
    recursive = true;
  };
}
