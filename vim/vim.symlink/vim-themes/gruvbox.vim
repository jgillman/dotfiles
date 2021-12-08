" Link this file to theme.vim to set a theme
" ln -sf ./vim-themes/gruvbox.vim theme.vim

set background=dark

if has#colorscheme('gruvbox')
  colorscheme gruvbox
endif

" Set the background color as transparent to 'inherit' from the terminal's
" background color.
hi Normal guibg=NONE ctermbg=NONE
