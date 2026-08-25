{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      gruvbox
      # voeg hier andere plugins toe
    ];
    extraConfig = ''
      " Gruvbox instellingen
      colorscheme gruvbox
      set background=dark
      
      " Optionele Gruvbox tweaks
      let g:gruvbox_contrast_dark = 'hard'
      let g:gruvbox_invert_selection = '0'
    '';
  };
}