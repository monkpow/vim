version 6.0
set nocompatible
let s:cpo_save=&cpo
set cpo&vim
inoremap <S-Tab> 
imap <F8> ggVG!~/.vim/scripts/jsTidy.rb ^M :w a
map! <xHome> <Home>
map! <xEnd> <End>
map! <S-xF4> <S-F4>
map! <S-xF3> <S-F3>
map! <S-xF2> <S-F2>
map! <S-xF1> <S-F1>
map! <xF4> <F4>
map! <xF3> <F3>
map! <xF2> <F2>
map! <xF1> <F1>
nmap ,1 :sp ~/.vim/colors/nik.vim
nmap ,v :sp ~/.vim/vimrc/.vimrc
nmap ,s :source ~/.vim/vimrc/.vimrc
nmap - -      
vnoremap < <gv
nmap = +
vnoremap > >gv
vmap [% [%m'gv``
map \mbt <Plug>TMiniBufExplorer
map \mbu <Plug>UMiniBufExplorer
map \mbc <Plug>CMiniBufExplorer
map \mbe <Plug>MiniBufExplorer
map <silent> \bv :VSBufExplorer
map <silent> \bs :SBufExplorer
map <silent> \be :BufExplorer
vmap ]% ]%m'gv``
vmap a% [%v]%
nmap gtf vt":sp gvgf   
nmap <F8> :mkview!maggVG!~/.vim/scripts/jsTidy.rb  :w :loadview
vmap <F7> ,c gv
nmap <F7> ,c gv
nmap <F6> :set number!
nmap <F5> <F2><F3>
nmap <F4> 100-
nmap <F3> 100=
nmap <F2> w
map <xHome> <Home>
map <xEnd> <End>
map <S-xF4> <S-F4>
map <S-xF3> <S-F3>
map <S-xF2> <S-F2>
map <S-xF1> <S-F1>
map <xF4> <F4>
map <xF3> <F3>
map <xF2> <F2>
map <xF1> <F1>
imap 	 
imap  =CtrlXPP()
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=2
set nobuflisted
set complete=.,w,b,u,t,i,k
set dictionary=~/.vim/templates/code.complete
set encoding=utf-8
set noequalalways
set expandtab
set fileencodings=ucs-bom,utf-8,latin1
if &filetype != 'ruby'
set filetype=ruby
endif
set history=1000
set hlsearch
set iskeyword=@,48-57,_,192-255,:
set laststatus=2
set shiftwidth=2
set showmatch
if &syntax != 'javascript'
set syntax=javascript
endif
set tabstop=2
set winminheight=0
