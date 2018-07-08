" Plugins
call plug#begin('D:\apanfutov\install\gvim_8.1.0105_x64\vim\vim81\plugged')
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'Valloric/YouCompleteMe'
  Plug 'morhetz/gruvbox'
  Plug 'jiangmiao/auto-pairs'
  Plug 'easymotion/vim-easymotion'
call plug#end()

colorscheme gruvbox
syntax on
set background=dark
set fileencodings=utf-8,cp1251,koi8-r,cp866
set encoding=cp1251
set termencoding=utf-8                       " set terminal encoding

set keymap=russian-jcukenwin
set langmenu=en_US
let $LANG = 'en_US'
let c_comment_strings=1
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan

autocmd vimenter * NERDTree
set number

let g:mapleader=','
set expandtab
set shiftwidth=2
set tabstop=2
set hlsearch
set incsearch

"mappings
map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easy-motion prefix)

map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! WinMove(key)
        let t:curwin = winnr()
        exec "wincmd ".a:key
        if (t:curwin == winnr())
                if (match(a:key, '[jk]'))
                        wincmd v
                else 
                        wincmd s
                endif
                exec "wincmd ".a:key
         endif
endfunction 
