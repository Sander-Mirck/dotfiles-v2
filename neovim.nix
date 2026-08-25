{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''
        colorscheme gruvbox
        set background=dark
        let g:gruvbox_contrast_dark = 'hard'
        let g:gruvbox_invert_selection = '0'
      '';
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [ gruvbox ];
      };
    };
  };
}