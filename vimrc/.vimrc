"set incsearch
set shiftwidth=2
set autoindent
set showmatch
set expandtab 
set encoding=utf-8
set laststatus=2 " shows the statusbar, ruler, etc.
set complete+=k
set dictionary+=~/.vim/templates/code.complete
set iskeyword+=:
set wmh=0 "minimum window hieght
set history=500
"set cursorline
set hlsearch
set foldmethod=indent
set sw=2 ts=2 sts=2

"plugin settings
"supertab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>" 
let g:bufExplorerSplitBelow=1
let g:bufExplorerSplitType='v' 

syntax on
filetype plugin on
filetype indent on

augroup filetype
au!
au! BufRead,BufNewFile *.js  set filetype=javascript
au! BufRead,BufNewFile *.js  set foldmethod=indent
au! BufRead,BufNewFile *.sh  set dictionary+=~/.vim/wordlists/bash.list
au! BufRead,BufNewFile *.tag set filetype=jsp
au! BufRead,BufNewFile *.py  set filetype=python
au! BufRead,BufNewFile *.rb  set filetype=ruby
au! BufRead,BufNewFile *.css set filetype=css dictionary+=~/.vim/wordlists/css.list omnifunc=csscomplete#CompleteCSS
au! BufRead,BufNewFile *.php set filetype=htm
autocmd FileType javascript  set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html        set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css         set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml         set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php         set omnifunc=phpcomplete#CompletePHP
autocmd FileType c           set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby,yaml set ai sw=2 sts=2 et
autocmd FileType javascript nmap <F8> :mkview!maggVG!~/.vim/scripts/jsTidy.rb  :w :loadview
autocmd FileType ruby,eruby,yaml nmap <F8> :mkview!maggVG%!ruby-code-indenter:loadview

autocmd BufRead,BufNewFile *.py set filetype=python smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
augroup END

" http://www.vex.net/~x/python_and_vim.html

"show tabs, spaces, end of lines
"set list
set listchars=tab:>-,trail:.
set shell=bash

syntax on


autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl
au Syntax css source ~/.vim/syntax/css.vim
nmap = +
" MAKE IT EASY TO UPDATE/RELOAD _vimrc
nmap ,s :source ~/.vim/vimrc/.vimrc
nmap ,v :sp ~/.vim/vimrc/.vimrc
" MAKE IT EASY TO UPDATE/RELOAD colorscheme
nmap ,1 :sp ~/.vim/colors/nik.vim
vnoremap < <gv
vnoremap > >gv
nmap - -      
nmap gtf vt":sp gvgf   
nmap <F2> w
nmap <F3> 100=
nmap <F4> 100-
nmap <F5> <F2><F3>
nmap <F6> :set number!
nmap <F7> ,c gv

"nmap <F8> :mkview!maggVG!~/.vim/scripts/jsTidy.rb  :w :loadview
"nmap <F7> :%!ruby-code-indenter<cr> 
"nmap <space> zA
	
colorscheme nik
"highlight CursorLine ctermbg=white cterm=reverse
set grepprg=grep\ -nH\ $*  " experimental, from brians .vimrc


silent! ruby nil 
nmap <leader>rci :%!ruby-code-indenter<cr> 


