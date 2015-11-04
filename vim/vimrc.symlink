set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" ----------------------------------------------------------------------------
"  Bundles
" ----------------------------------------------------------------------------

" Interface / UI
Plugin 'christoomey/vim-tmux-navigator'

" Git
Plugin 'airblade/vim-gitgutter.git'

" Color Themes
Plugin 'altercation/vim-colors-solarized.git'
Plugin 'morhetz/gruvbox.git'

" Utility
Plugin 'ag.vim'
Plugin 'ctrlpvim/ctrlp.vim.git'
Plugin 'tpope/vim-commentary.git'
Plugin 'tpope/vim-surround.git'
Plugin 'vasconcelloslf/vim-interestingwords'
Plugin 'vim-scripts/Align.git'

" Everything else
Plugin 'kchmck/vim-coffee-script.git'
Plugin 'scrooloose/syntastic.git'
Plugin 'tpope/vim-fugitive.git'
Plugin 'tpope/vim-haml.git'
Plugin 'tpope/vim-rails.git'


call vundle#end()
filetype plugin indent on

set noswapfile

set runtimepath^=~/.vim/bundle/ctrlp.vim  " Setup ctrlp

" ----------------------------------------------------------------------------
"  Basic Editing Config
" ----------------------------------------------------------------------------

set backup                 " Store temporary files in a central spot
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set encoding=utf-8         " UTF8 or bust!
set hidden                 " allow unsaved buffers in the background
set autoindent             " automatic indent new lines
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=2
set shiftwidth=2
set tabstop=2
set formatoptions+=n       " support for numbered/bullet lists
set virtualedit=block      " allow virtual edit in visual block ..
set cpoptions+=$           " add the dollar character when changing a word


" ----------------------------------------------------------------------------
"  Status line
" ----------------------------------------------------------------------------

set statusline=                        " clear the statusline for when vimrc is reloaded
set statusline+=%<                     " truncate from here
set statusline+=\ %f\                  " path to file relative to current dir
set statusline+=(%{&ft})\              " filetype
set statusline+=%-4(%m%)               " modified flag
set statusline+=%=                     " switch to right side
set statusline+=%-20(%4l,%-3c\ \ %P%)  " cursor position


let g:ctrlp_max_files=20000      " double number of files scanned
let g:ctrlp_custom_ignore={
  \ 'dir':  '\v(\.(git|hg|svn))|(db/(data|dumps))|(_local_s3|log|public|tmp|work)|(_bower_components|_site|node_modules)$',
  \ 'file': '\v(*.sublime-)|(\.(exe|so|dll))$'
  \ }

if executable("ag")
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
endif


" ----------------------------------------------------------------------------
"  Auto commands
" ----------------------------------------------------------------------------

" Jump to last cursor position unless it's invalid or in an event handler
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

autocmd BufWritePre * call StripTrailingWhitespace()


" ----------------------------------------------------------------------------
"  Colors
" ----------------------------------------------------------------------------

syntax enable
colorscheme gruvbox
set background=dark


" ----------------------------------------------------------------------------
"  Remapping
" ----------------------------------------------------------------------------

" lead with ,
let mapleader = "\<Space>"

" Always search regular regex
nnoremap / /\v
vnoremap / /\v

" Toggle paste mode
nmap <leader>p :set invpaste<cr>:set paste?<cr>

" Open files with <leader>f
map <leader>f :CtrlP<cr>
" Open file window with currently open buffers
nmap <leader>b :CtrlPBuffer<cr>

" Close current buffer without closing split
nmap <leader>c :bprevious \| bdelete #<cr>

" Switch between the last two files
" nnoremap <leader><leader> <c-^>

" exit to normal mode with 'jj' or 'kk'
inoremap jj <ESC>
inoremap kk <ESC>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" sane movement with wrap turned on
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" stop using arrow keys
map <Left> :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up> :echo "no!"<cr>
map <Down> :echo "no!"<cr>

" stop accidentally opening help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" helpful split resizing
nnoremap - <c-w>-
nnoremap + <c-w>+

" Indent if we're at the beginning of a line. Else, do completion.
" (from Destroy All Software)
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>


" ----------------------------------------------------------------------------
"  UI
" ----------------------------------------------------------------------------

set ruler                  " show the cursor position all the time
set noshowcmd              " don't display incomplete commands
set lazyredraw             " turn off lazy redraw
set wildmenu               " turn on wild menu
set wildmode=list:longest,full
set ch=2                   " command line height
set backspace=2            " allow backspacing over everything in insert mode
set whichwrap+=<,>,h,l,[,] " backspace and cursor keys wrap to
set shortmess=filtIoOA     " shorten messages
set report=0               " tell us about changes
set nostartofline          " don't jump to the start of line when scrolling
set scrolloff=8            " keep 8 lines of space above and below the cursor
set ttyfast                " always assume a fast connection
set modeline               " use in-file settinges when available
set modelines=2


" ----------------------------------------------------------------------------
" Visual Cues
" ----------------------------------------------------------------------------

set showmatch              " brackets/braces that is
set mat=5                  " duration to show matching brace (1/10 sec)
set incsearch              " do incremental searching
set laststatus=2           " always show the status line
set ignorecase             " use case insensitive searching
set smartcase              " ^ unless a capital letter is used
set hlsearch               " highlight searches
set gdefault               " always search globally
set colorcolumn=79,112     " highlight column 79 as a soft reminder


" ----------------------------------------------------------------------------
"  Strip all trailing whitespace in file
" ----------------------------------------------------------------------------

function! StripTrailingWhitespace ()
  " Don't strip on these filetypes
  if &ft =~ 'sql'
    return
  endif
  %s/\s\+$//e
endfunction


" ----------------------------------------------------------------------------
"  Rename current file
" ----------------------------------------------------------------------------

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'))
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
command! RenameFile :call RenameFile()


" ----------------------------------------------------------------------------
"  Per-filetype settings
" ----------------------------------------------------------------------------

au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.rb setl shiftwidth=2 expandtab
au BufNewFile,BufReadPost *.md setl ft=markdown expandtab

set expandtab


" ----------------------------------------------------------------------------
"  Source local vimrc config
" ----------------------------------------------------------------------------

if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif
