{ config, pkgs, lib, ... }:
{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;

    viAlias = true;
    vimdiffAlias = true;

    withNodeJs = true;
    withPython3 = true;

    plugins = with pkgs.vimPlugins; [
      # TODO: install plugins via nix
      # vim-surround
      # vim-repeat
      # fugitive
      # vim-table-mode
      # plenary-nvim
      # telescope-nvim
      # nvim-treesitter
      # nvim-lspconfig
      # nvim-webdev-icons
    ];

    extraPackages = with pkgs; [
      # Language Servers
      rnix-lsp
      sumneko-lua-language-server
      java-language-server
    ];

    extraConfig = ":luafile ~/.config/nvim/lua/init.lua";
  };

  xdg.configFile = {
    nvim = {
      source = ./config/nvim;
      recursive = true;
    };
    # TODO: pre-install treesitter grammars
  };
}
