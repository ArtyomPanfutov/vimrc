source $vimruntime/vimrc_example.vim

set fileencodings=utf-8,cp1251,koi8-r
set encoding=utf-8
set termencoding=utf-8                       " set terminal encoding
set diffexpr=mydiff()

" :pluginstall 
" configuring powerline: https://www.tecmint.com/powerline-adds-powerful-statuslines-and-prompts-to-vim-and-bash/
"========================== plugins ========================
call plug#begin('~/.vim/plugged')
  plug 'scrooloose/nerdtree', { 'on':  'nerdtreetoggle' }
  plug 'valloric/youcompleteme'
  plug 'morhetz/gruvbox'
  plug 'jiangmiao/auto-pairs'
  plug 'easymotion/vim-easymotion'
  plug 'powerline/powerline'
call plug#end()
"===========================================================

autocmd guienter * silent! wtoggleclean

let g:gruvbox_italic=1
colorscheme gruvbox
syntax on

" powerline 
set  rtp+=/home/artyom/.local/lib/python2.7/site-packages/powerline/bindings/vim/
set laststatus=2
set t_co=256
set background=dark

set langmenu=en_us
let $lang = 'en_us'
set keymap=russian-jcukenwin

" english at start (start > i)
set iminsert=0 

" search in english at start (start > /)
set imsearch=0 
set guifont=lucida\ console:h9

" change lang 
inoremap <c-l> <c-^> 
highlight lcursor guifg=none guibg=cyan " 
let c_comment_strings=1
source $vimruntime/delmenu.vim
source $vimruntime/menu.vim
set iminsert=0
set imsearch=0
highlight lcursor guifg=none guibg=cyan

autocmd vimenter * nerdtree
set number
set relativenumber

let g:mapleader=','
set expandtab
set shiftwidth=2
set tabstop=2
set hlsearch
set incsearch
set ignorecase

"mappings
map <c-n> :nerdtreetoggle<cr>
map <leader> <plug>(easy-motion prefix)

map <silent> <c-h> :call winmove('h')<cr>
map <silent> <c-j> :call winmove('j')<cr>
map <silent> <c-k> :call winmove('k')<cr>
map <silent> <c-l> :call winmove('l')<cr>

vnoremap < <gv
vnoremap > >gv

"vnoremap <c-c> "+y
"vnoremap <c-x> "+x
"map <c-v> "+p

nmap // :linescommentnextstate <cr>
vmap // :linescommentnextstate <cr>

"========================= functions ========================
function! winmove(key)
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


function! s:linescommentnextstate() range

    let l:extension = expand('%:e')

    let l:comment_symbol = "#"
    if l:extension == "c"
        let l:comment_symbol = "\/\/"
    elseif l:extension == "cpp"
        let l:comment_symbol = "\/\/"
    elseif l:extension == "h"
        let l:comment_symbol = "\/\/"
    elseif l:extension == "hpp"
        let l:comment_symbol = "\/\/"
    elseif l:extension == "xs"
        let l:comment_symbol = "\/\/"
    elseif l:extension == "vim"
        let l:comment_symbol = "\""
    elseif l:extension == "lua"
        let l:comment_symbol = "--"
    elseif l:extension == "sql"
        let l:comment_symbol = "--"
    elseif l:extension == "pas"
        let l:comment_symbol = "\/\/"

    else
        "default '#'
    endif

    let l:first_line = getline(a:firstline)

    let l:need_comment = 1

    " if string already commented, no need comment twice
    if l:first_line =~ '\v^(\s)*' . l:comment_symbol
        let l:need_comment = 0
    endif

    for n in range (a:firstline, a:lastline)
        let l:line = getline (n)

        if len(l:line) == 0
            continue
        endif

        if l:need_comment == 1
            " comment it!
            let l:new_line = l:comment_symbol . l:line

            " but if beginning from space, need save all spaces
            if l:line =~ '\v^\s'
                let l:matches = matchlist(l:line, '\v^(\s+)(.*)')
                let l:new_line = l:matches[1] . l:comment_symbol . l:matches[2]
            endif
        else
            let l:new_line = l:line

            if l:line =~ '\v^(\s*)' . l:comment_symbol
                let l:matches = matchlist(l:line, '\v^(\s*)' . l:comment_symbol . '(.*)')
                let l:new_line = l:matches[1] . l:matches[2]
            endif
        endif

        call setline (n, l:new_line)
    endfor
endfunction

function! savecursor()
    let s:cursor = getpos('.')
endfunction

function! restorecursor()
    call setpos('.', s:cursor)
    unlet s:cursor
endfunction

function! mydiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $vimruntime =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $vimruntime . '\diff"'
    else
      let cmd = substitute($vimruntime, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $vimruntime . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
command! -range linescommentnextstate call savecursor() | <line1>,<line2>call s:linescommentnextstate() | call restorecursor()
