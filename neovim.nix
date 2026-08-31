{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        lua << EOF
          vim.o.background = "dark"
          vim.cmd([[colorscheme gruvbox]])
        EOF
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ gruvbox-nvim ];
      };
    };
  };
}