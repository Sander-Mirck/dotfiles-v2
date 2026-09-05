{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;

    configure = {
      customRC = ''
        set number relativenumber termguicolors
        lua << EOF
          vim.o.background = "dark"
          vim.cmd.colorscheme("nord")
        EOF
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ nord-nvim ];
      };
    };
  };
}