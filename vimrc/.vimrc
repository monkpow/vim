set autoindent
set complete+=k
set dictionary+=~/.vim/templates/code.complete
set encoding=utf-8
set expandtab 
set foldlevel=2
set foldmethod=indent 
set hidden
set history=1000 
set hlsearch  " highlight search terms

"status line stuff
set laststatus=2 " shows the statusbar, ruler, etc.
set laststatus=2
set statusline=
set statusline+=%f\ " file name
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset
set statusline+=%h%1*%m%r%w%0* " flags
set statusline+=%#warningmsg#
set statusline+=%*

set shell=bash
set showmatch
set sw=2 ts=2 sts=2 " shiftwidth, tabsize and softtabsize
set tabstop=2
set t_Co=256 "enable 256 colors
set wmh=0 "minimum window hieght

" http://items.sjbach.com/319/configuring-vim-right
let mapleader=','
set wildmenu
set wildmode=list:longest
set title

syntax on
filetype plugin on
filetype indent on

autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl
" kill trailing whitespace on save
autocmd BufWritePre *.js :%s/\s\+$//e
au Syntax css source ~/.vim/syntax/css.vim

nmap ,s :source ~/.vim/vimrc/.vimrc
nmap ,v :sp ~/.vim/vimrc/.vimrc
nmap = +  " convenience for add one line to this split
nmap - -  " remove one line from this split
nmap gtf vt":sp
nmap gvgf  " open the file under cursor in a split
nmap ,2 w  " change windows
nmap ,3 :only
  
nmap ,4 :ball
nmap ,5 :set number!
nmap ,d :NERDTreeToggle

" Make tab indent work the way I like it
vnoremap < <gv
vnoremap > >gv

" cleanup whitespace at end of line
:nnoremap <silent> ,7 :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR> :retab

colo 256_asu1dark
"colo blueshift
colo charged-256
"colo fruit
highlight Pmenu ctermbg=gray cterm=bold ctermfg=darkblue

silent! ruby nil

"http://tim.theenchanter.com/2008/07/crontab-temp-file-must-be-edited-in.html
"vim 7.1 has issues editing crontab without this setting
set backupskip=/tmp/*,/private/tmp/*"

"store swap files in my tmp dir
set dir=/tmp

" syntastic plugin
"let g:syntastic_enable_signs=1
"let g:syntastic_auto_loc_list=1

"disable jslint line highlighting, because it is annoying me
let g:JSLintHighlightErrorLine = 0

" Attempt to highlight extra whitespace and bad formatting
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
highlight MissingWhitespace ctermbg=red guibg=red
highlight HashRocketNO ctermbg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/
autocmd Syntax * syn match HashRocketNO /=>/

" highlight lines longer than 120 chars
highlight OverLength ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match OverLength /\%121v.*/

highlight JSFunctionWhiteSpace ctermbg=darkred ctermfg=white guibg=#FFD9D9
match JSFunctionWhiteSpace /function(/
"match Todo /hey/

"highlight JSParens ctermbg=darkred ctermfg=white guibg=#FFD9D9
"match JSParens /( /


" a few notes i want to remember 

" help:yank from buffer to command line
":h c_ctrl-r "CTRL-R {0-9a-z"%#:-=.} 

" break css declarations into multiline
"nmap ,z :%s/{\([^}]*\)$/{\r\1/g
":%s/^\([^{]*\)}/\1\r}/g
"

abbr ios iOS
abbr iOs iOS
abbr IOS iOS

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


" syntastic!
let g:syntastic_javascript_checkers = ['jshint']
