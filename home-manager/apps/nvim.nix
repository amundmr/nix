{config, pkgs, ...}:

{
  programs.neovim = {
    enable = true;
    extraConfig = ''
      " Bindings
      nnoremap <C-t> :NERDTreeToggle<CR> " Ctrl + t to toggle the NERDTree!

      nmap <F8> :TagbarToggle<CR>
    '';
    plugins = with pkgs.vimPlugins; [
      vim-airline
      nerdtree
      vim-devicons
      nvim-lspconfig
    ];
  };
}
