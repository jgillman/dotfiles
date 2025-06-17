set background=dark

if has#colorscheme(g:my_theme)
  execute 'colorscheme ' . g:my_theme
endif

" Set the background color as transparent to 'inherit' from the terminal's
" background color.
hi Normal ctermbg=NONE
