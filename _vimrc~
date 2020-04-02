source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
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
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction
" Plugins
call plug#begin('D:\apanfutov\install\gvim_8.1.0105_x64\vim\vim81\plugged')
  Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
  Plug 'Valloric/YouCompleteMe'
  Plug 'morhetz/gruvbox'
  Plug 'jiangmiao/auto-pairs'
  Plug 'easymotion/vim-easymotion'
call plug#end()

autocmd GUIEnter * silent! WToggleClean

let g:gruvbox_italic=1
colorscheme gruvbox
syntax on

" vimtweak calls 
call libcallnr("vimtweak64.dll", "SetAlpha", 240)

set background=dark
set fileencodings=cp866,utf-8,cp1251,koi8-r
set encoding=cp866
set termencoding=utf-8                       " set terminal encoding

set langmenu=en_US
let $LANG = 'en_US'
set keymap=russian-jcukenwin
" English at start (start > i)
set iminsert=0 
" Search in english at start (start > /)
set imsearch=0 
set guifont=Lucida\ Console:h9
" Change lang 
inoremap <C-l> <C-^> 
highlight lCursor guifg=NONE guibg=Cyan " Смена цвета курсора
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
set ignorecase

"mappings
map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easy-motion prefix)

map <silent> <C-h> :call WinMove('h')<CR>
map <silent> <C-j> :call WinMove('j')<CR>
map <silent> <C-k> :call WinMove('k')<CR>
map <silent> <C-l> :call WinMove('l')<CR>

vnoremap < <gv
vnoremap > >gv

vnoremap <C-c> "+y
vnoremap <C-X> "+x
map <C-v> "+p

nmap // :LinesCommentNextState <CR>
vmap // :LinesCommentNextState <CR>
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


function! s:LinesCommentNextState() range

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

function! SaveCursor()
    let s:cursor = getpos('.')
endfunction

function! RestoreCursor()
    call setpos('.', s:cursor)
    unlet s:cursor
endfunction

command! -range LinesCommentNextState call SaveCursor() | <line1>,<line2>call s:LinesCommentNextState() | call RestoreCursor()
