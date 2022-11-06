{ config, lib, pkgs, user, ... }:

{
  programs.tmux = {
    enable = true;
    tmuxinator.enable = true;
    keyMode = "emacs";
    shortcut = "f";
    terminal = "screen-256color";
    clock24 = true;
    escapeTime = 1;
    historyLimit = 50000;
    plugins = with pkgs; [
      tmuxPlugins.urlview
    ];
    extraConfig = ''
      # Status bar colors
      set-option -g status-style bg=default # transparent bg
      set -g status-fg white
      set-window-option -g window-status-current-style fg=black,bg=white

      setw -g mouse on

      # Reload tmux.conf
      unbind r
      bind r source-file ~/.tmux.conf

      # VI style movements
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # VI style resize 
      bind -r C-h resizep -L
      bind -r C-j resizep -D
      bind -r C-k resizep -U
      bind -r C-l resizep -R

      # VI style copy/paste
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      # Jump to last pane and maximize it
      bind O "last-pane ; resize-pane -Z"

      # Toggle status bar
      bind-key q set-option status

      # Center windows in status line
      set -g status-justify centre

      # Open from current directory
      bind C-c new-window -c '#{pane_current_path}'
      bind '"' split-window -c '#{pane_current_path}'
      bind % split-window -h -c '#{pane_current_path}'

      # Search cheatsheet (thanks to the primeagen)
      # TODO: bind -r i run-shell "tmux popup -w 75% -h 75% ~/cht.sh.tmux.sh"
    '';
  };
}
