" good article with useful defaults
" http://nvie.com/posts/how-i-boosted-my-vim/

set autoindent
set complete+=k
set encoding=utf-8
set expandtab
set foldlevel=2
set foldmethod=indent
set hidden   " hide buffers instead of closing them
set history=1000
set hlsearch      " highlight search terms
set copyindent    " copy the previous indentation on autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set showmatch     " set show matching parenthesis
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set shell=bash
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set sw=2 ts=2 sts=2 " shiftwidth, tabsize and softtabsize
set t_Co=256 "enable 256 colors
set wmh=0 "minimum window hieght

"status line stuff
set laststatus=2 " shows the statusbar, ruler, etc.
set statusline=
set statusline+=%f\ " file name
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset
set statusline+=%h%1*%m%r%w%0* " flags
set statusline+=%#warningmsg#
set statusline+=%*

" highlight unwanted whitespace
set list
set listchars=tab:>~,trail:~,extends:#,nbsp:~

" http://items.sjbach.com/319/configuring-vim-right
let mapleader=','
set wildmenu
set wildmode=list:longest
set title

syntax on
filetype plugin on
filetype indent on

" when creating a new file (i.e. new t.html), use a template if one exists (e.g. html.tpl)
" looks in ~/.vim/templates
autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl

" kill trailing whitespace on save
autocmd BufWritePre *.js :%s/\s\+$//e
autocmd BufNewFile,BufRead *.scss             set ft=scss
autocmd BufNewFile,BufRead *.less             set ft=less.css
autocmd BufNewFile,BufRead *.json             set ft=javascript

au Syntax css source ~/.vim/syntax/css.vim

" easy edit vimrc
nmap ,s :source ~/.vim/vimrc/.vimrc
nmap ,v :sp ~/.vim/vimrc/.vimrc

" window size
nmap = +  " convenience for add one line to this split
nmap - -  " remove one line from this split
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

function! CleanJson()
  %s/\([{|}]\)/\r\1\r/g
  %s/\(\[\)/[\r/g
  %s/\(\]\)/\r]/g
  %s/\,/,\r/g
  %s/}\n,/},/g
  "%s/}\n\s*\n}/}\r}/g
  %s/^\s*$\n//
  normal! ggVG=
  retab
endfunction

colo github
colo 256_automation
colo lucius
LuciusDark "(dark default)
"LuciusDarkHighContrast
LuciusDarkLowContrast
"LuciusBlack
"LuciusBlackHighContrast
"LuciusBlackLowContrast
"LuciusLight "(light default)
"LuciusLightLowContrast
"LuciusWhite
"LuciusWhiteLowContrast



" fix terrible highlighting and folding colors
highlight Pmenu ctermbg=gray cterm=bold ctermfg=darkblue
highlight Folded ctermbg=None ctermfg=Gray

silent! ruby nil

"http://tim.theenchanter.com/2008/07/crontab-temp-file-must-be-edited-in.html
"vim 7.1 has issues editing crontab without this setting
set backupskip=/tmp/*,/private/tmp/*"

"store swap files in my tmp dir
set dir=/tmp

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
match OverLength /\%121v.*/

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
let g:syntastic_javascript_checkers = ['jscs', 'jshint']
"let g:syntastic_javascript_checkers = ['jshint', 'jscs']
"let g:syntastic_aggregate_errors = 1
"let g:syntastic_css_checkers = ['csslint']

" never mis-spell iOS again
abbr ios iOS
abbr iOs iOS
abbr IOS iOS


" alias for jira_client
abbr !j !jira_client

"""""""""""""""""""""""""""""""""""""""""""""""""""
" a few notes i want to remember
"""""""""""""""""""""""""""""""""""""""""""""""""""

" help:yank from buffer to command line
":h c_ctrl-r "CTRL-R {0-9a-z"%#:-=.}

" break css declarations into multiline
"nmap ,z :%s/{\([^}]*\)$/{\r\1/g
":%s/^\([^{]*\)}/\1\r}/g

execute pathogen#infect()


" recommended by syntastic, not sure I agree
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
