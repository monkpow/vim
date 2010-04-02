set t_Co=256 "enable 256 colors
set hidden
set autoindent
set complete+=k
set dictionary+=~/.vim/templates/code.complete
set encoding=utf-8
set expandtab
set foldmethod=indent
set foldlevel=2
set history=1000
set hlsearch
set iskeyword+=:
set laststatus=2 " shows the statusbar, ruler, etc.
set list listchars=tab:>-,trail:. "show tabs, spaces, end of lines
  set shell=bash
set showmatch
set sw=2 ts=2 sts=2
set wmh=0 "minimum window hieght
"set foldminlines  5
set foldlevel=1
"plugin settings
"supertab
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:bufExplorerSplitBelow=1
"let g:bufExplorerSplitType='v'

syntax on
filetype plugin on
filetype indent on

augroup filetype
au!
au! BufRead,BufNewFile *.js  set filetype=javascript
au! BufRead,BufNewFile *.sh                                          set dictionary+=~/.vim/wordlists/bash.list
au! BufRead,BufNewFile *.tag                                         set filetype=jsp
au! BufRead,BufNewFile *.py                                          set filetype=python
au! BufRead,BufNewFile *.rb                                          set filetype=ruby "equalprg=~/.vim/scripts/rbTidy/rbTidy.rb
au! BufRead,BufNewFile *.erb                                         set filetype=eruby
au! BufRead,BufNewFile *.css                                         set filetype=css dictionary+=~/.vim/wordlists/css.list omnifunc=csscomplete#CompleteCSS
au! BufRead,BufNewFile *.php                                         set filetype=htm
au! BufRead,BufNewFile *.py                                          set filetype=python smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
au! BufRead,BufNewFile *.html                                        set filetype=html

au! FileType html                                                    set foldmethod=indent foldlevel=1
autocmd FileType css                                                 set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml                                                 set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php                                                 set omnifunc=phpcomplete#CompletePHP
autocmd FileType c                                                   set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby,yaml                                     set ai sw=2 sts=2 et
autocmd FileType ruby,eruby                                          set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd Filetype ruby,eruby                                          set cinoptions=:0,p0,t0 cinwords=if,else,while,do,for,switch,case
autocmd Filetype ruby,eruby set foldmethod=indent foldlevel=1

augroup END

autocmd BufNewFile * silent! 0r ~/.vim/templates/%:e.tpl
"autocmd BufWritePre *rb :%s/\s\+$//




au Syntax css source ~/.vim/syntax/css.vim
nmap = +
" MAKE IT EASY TO UPDATE/RELOAD _vimrc
nmap ,s :source ~/.vim/vimrc/.vimrc
nmap ,v :sp ~/.vim/vimrc/.vimrc

" Make tab indent work the way I like it
vnoremap < <gv
vnoremap > >gv

nmap - -
nmap gtf vt":sp gvgf
nmap <F2> w
nmap <F3> :only
nmap <F4> :ball
nmap <F6> :set number!

nmap ,b :HSBufExplorer
nmap ,d :NERDTreeToggle

" cleanup whitespace at end of line
:nnoremap <silent> <F7> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR> :retab

colorscheme inkpot
"colo aiseered_edit
"colo nik_trans
" make autocomplete menu a reasonable color
highlight Pmenu ctermbg=gray cterm=bold ctermfg=darkblue

"colo fruidle 
" color the popup menu
"highlight Pmenu ctermbg=olive cterm=none ctermfg=red
"highlight PmenuSel ctermbg=gray cterm=bold ctermfg=red
set grepprg=grep\ -nH\ $*  " experimental, from brians .vimrc


silent! ruby nil

"http://tim.theenchanter.com/2008/07/crontab-temp-file-must-be-edited-in.html
"vim 7.1 has issues editing crontab without this setting
set backupskip=/tmp/*,/private/tmp/*"


" TODO kind of stuff
" figure out tags
"
"


" for rcodetools plugin
let g:rct_completion_use_fri = 1
set completeopt=menu,preview

" Nice statusbar
 set laststatus=2
 set statusline=
 set statusline+=%f\ " file name
 "set statusline+=\[%{strlen(&ft)?&ft:'none'}] " filetype
 set statusline+=%= " right align
 set statusline+=%-14.(%l,%c%V%)\ %<%P " offset
 set statusline+=%h%1*%m%r%w%0* " flags

 " for taglist, ctags
"
let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Use_Right_Window = 1




" Experimental: from http://vim.wikia.com/wiki/Using_vim_as_an_IDE_all_in_onehttp://vim.wikia.com/wiki/Using_vim_as_an_IDE_all_in_one

" --------------------
" TagList
" --------------------
" F4: Switch on/off TagList
"nnoremap <silent> <F4> :TlistToggle<CR>
" TagListTagName - Used for tag names
"highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
"" TagListTagScope - Used for tag scope
"highlight MyTagListTagScope gui=NONE guifg=Blue
"" TagListTitle - Used for tag titles
"highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray
"" TagListComment - Used for comments
"highlight MyTagListComment guifg=DarkGreen
"" TagListFileName - Used for filenames
"highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue
""let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool
"let Tlist_Show_One_File = 1 " Displaying tags for only one file~
"let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
"let Tlist_Use_Right_Window = 1 " split to the right side of the screen
"let Tlist_Sort_Type = "order" " sort by order or name
"let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
"let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
"let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
"let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
"let Tlist_Close_On_Select = 1 " Close the taglist window when a file or tag is selected.
"let Tlist_Enable_Fold_Column = 0 " Don't Show the fold indicator column in the taglist window.
"let Tlist_WinWidth = 40
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]

" --------------------
" MiniBufExpl
" --------------------
"let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
"let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
"let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
"let g:miniBufExplMaxSize = 1 " <max lines: defualt 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers.
"let g:miniBufExplForceSyntaxEnable = 1 " There is a Vim bug that can cause buffers to show up without their highlighting. The following setting will cause MBE to
"let g:miniBufExplorerMoreThanOne = 1 " Setting this to 0 will cause the MBE window to be loaded even
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplMapWindowNavArrows = 1
"for buffers that have NOT CHANGED and are NOT VISIBLE.
"highlight MBENormal guibg=LightGray guifg=DarkGray
" for buffers that HAVE CHANGED and are NOT VISIBLE
"highlight MBEChanged guibg=Red guifg=DarkRed
" buffers that have NOT CHANGED and are VISIBLE
"highlight MBEVisibleNormal term=bold cterm=bold gui=bold guibg=Gray guifg=Black
" buffers that have CHANGED and are VISIBLE
"highlight MBEVisibleChanged term=bold cterm=bold gui=bold guibg=DarkRed guifg=Black
"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplMapCTabSwitchBufs = 1
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplSplitBelow=21
"let g:miniBufExplVSplit = 25

" http://items.sjbach.com/319/configuring-vim-right
let mapleader=','
set wildmenu
set wildmode=list:longest
set title

"store swap files in my tmp dir
set dir=~/tmp

" break css declarations into multiline
"nmap ,z :%s/{\([^}]*\)$/{\r\1/g:%s/^\([^{]*\)}/\1\r}/g


" abbreviations
abbr cedit :sp ~/.vim/colors/inkpot.vim

" put a erb delimiter
abbr %% <%  %>hhhha
abbr %= <%=  %>hhhhha

