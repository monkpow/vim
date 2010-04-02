let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <C-Tab> 	
inoremap <S-Tab> 
imap <F8> gg=Ga
map! <Home> <Home>
map! <End> <End>
map! <S-F4> <S-F4>
map! <S-F3> <S-F3>
map! <S-F2> <S-F2>
map! <S-F1> <S-F1>
map! <F4> <F4>
map! <F3> <F3>
map! <F2> <F2>
map! <F1> <F1>
noremap  h
noremap <NL> j
noremap  k
noremap  l
nnoremap <silent>  :FuzzyFinderMruFile
nnoremap <silent>  :FuzzyFinderBuffer
vmap  <Plug>TwitvimVisual
nmap [13;2~ :only
nmap ,b :TMiniBufExplorer
nmap ,f :FuzzyFinderDir
nmap ,g :FuzzyFinderMruFile
map <silent> ,be :BufExplorer
map <silent> ,bs :SBufExplorer
map <silent> ,bv :VSBufExplorer
map ,mbe <Plug>MiniBufExplorer
map ,mbc <Plug>CMiniBufExplorer
map ,mbu <Plug>UMiniBufExplorer
map ,mbt <Plug>TMiniBufExplorer
nmap <silent> ,; :call ToggleSemicolonHighlighting()
nmap <silent> ,sc :call ToggleSemicolonHighlighting()
nmap <silent> ,aocom :AlignPush:AlignCtrl g /[*/],acom:AlignPop
nmap <silent> ,t@ :AlignCtrl mIp1P1=l @:'a,.Align
nmap ,j :!js
nmap ,x :!js -f %
map ,rwp <Plug>RestoreWinPosn
map ,swp <Plug>SaveWinPosn
nmap <silent> ,cI :call NERDComment(0, "prepend")
nmap <silent> ,cA :call NERDComment(0, "append")
nnoremap <silent> ,c$ :call NERDComment(0, "toEOL")
vnoremap <silent> ,cu :call NERDComment(1, "uncomment")
nnoremap <silent> ,cu :call NERDComment(0, "uncomment")
vnoremap <silent> ,cn :call NERDComment(1, "nested")
nnoremap <silent> ,cn :call NERDComment(0, "nested")
vnoremap <silent> ,cb :call NERDComment(1, "alignBoth")
nnoremap <silent> ,cb :call NERDComment(0, "alignBoth")
vnoremap <silent> ,cr :call NERDComment(1, "alignRight")
nnoremap <silent> ,cr :call NERDComment(0, "alignRight")
vnoremap <silent> ,cl :call NERDComment(1, "alignLeft")
nnoremap <silent> ,cl :call NERDComment(0, "alignLeft")
vmap <silent> ,cy :call NERDComment(1, "yank")
nmap <silent> ,cy :call NERDComment(0, "yank")
vnoremap <silent> ,ci :call NERDComment(1, "invert")
nnoremap <silent> ,ci :call NERDComment(0, "invert")
vnoremap <silent> ,cs :call NERDComment(1, "sexy")
nnoremap <silent> ,cs :call NERDComment(0, "sexy")
vnoremap <silent> ,cm :call NERDComment(1, "minimal")
nnoremap <silent> ,cm :call NERDComment(0, "minimal")
vnoremap <silent> ,c  :call NERDComment(1, "toggle")
nnoremap <silent> ,c  :call NERDComment(0, "toggle")
vnoremap <silent> ,cc :call NERDComment(1, "norm")
nnoremap <silent> ,cc :call NERDComment(0, "norm")
vmap <silent> ,Htd :<BS><BS><BS>ma'>,Htd
vmap <silent> ,tt :<BS><BS><BS>ma'>,tt
vmap <silent> ,tp@ :<BS><BS><BS>ma'>,tp@
vmap <silent> ,tsq :<BS><BS><BS>ma'>,tsq
vmap <silent> ,tsp :<BS><BS><BS>ma'>,tsp
vmap <silent> ,tml :<BS><BS><BS>ma'>,tml
vmap <silent> ,tab :<BS><BS><BS>ma'>,tab
vmap <silent> ,t@ :<BS><BS><BS>ma'>,t@
vmap <silent> ,t? :<BS><BS><BS>ma'>,t?
vmap <silent> ,t= :<BS><BS><BS>ma'>,t=
vmap <silent> ,t< :<BS><BS><BS>ma'>,t<
vmap <silent> ,t; :<BS><BS><BS>ma'>,t;
vmap <silent> ,t: :<BS><BS><BS>ma'>,t:
vmap <silent> ,ts, :<BS><BS><BS>ma'>,ts,
vmap <silent> ,t, :<BS><BS><BS>ma'>,t,
vmap <silent> ,t| :<BS><BS><BS>ma'>,t|
vmap <silent> ,anum :<BS><BS><BS>ma'>,anum
vmap <silent> ,afnc :<BS><BS><BS>ma'>,afnc
vmap <silent> ,adef :<BS><BS><BS>ma'>,adef
vmap <silent> ,adec :<BS><BS><BS>ma'>,adec
vmap <silent> ,ascom :<BS><BS><BS>ma'>,ascom
vmap <silent> ,aocom :<BS><BS><BS>ma'>,aocom
vmap <silent> ,acom :<BS><BS><BS>ma'>,acom
vmap <silent> ,abox :<BS><BS><BS>ma'>,abox
vmap <silent> ,a= :<BS><BS><BS>ma'>,a=
vmap <silent> ,a< :<BS><BS><BS>ma'>,a<
vmap <silent> ,a, :<BS><BS><BS>ma'>,a,
vmap <silent> ,a? :<BS><BS><BS>ma'>,a?
vmap <silent> ,Tsp :<BS><BS><BS>ma'>,Tsp
vmap <silent> ,T@ :<BS><BS><BS>ma'>,T@
vmap <silent> ,T= :<BS><BS><BS>ma'>,T=
vmap <silent> ,T< :<BS><BS><BS>ma'>,T<
vmap <silent> ,T: :<BS><BS><BS>ma'>,T:
vmap <silent> ,Ts, :<BS><BS><BS>ma'>,Ts,
vmap <silent> ,T, :<BS><BS><BS>ma'>,T,
vmap <silent> ,T| :<BS><BS><BS>ma'>,T|
map <silent> ,tdW@ :AlignCtrl v ^\s*/[/*]:AlignCtrl mWp1P1=l @:'a,.Align
map <silent> ,tW@ :AlignCtrl mWp1P1=l @:'a,.Align
omap <silent> ,t@ :AlignCtrl mIp1P1=l @:'a,.Align
omap <silent> ,aocom :AlignPush:AlignCtrl g /[*/],acom:AlignPop
nmap ,d :NERDTreeToggle
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
nmap gx <Plug>NetrwBrowseX
nmap gtf vt":sp gvgf
omap <F2> <F2>
vmap <F2> <F2>
omap <F3> <F3>
vmap <F3> <F3>
omap <F4> <F4>
vmap <F4> <F4>
nmap <F5> :TMiniBufExplorer
nmap <SNR>13_WS <Plug>AlignMapsWrapperStart
nmap <SNR>13_WE <Plug>AlignMapsWrapperEnd
nmap <F8> gg=G
vmap <F7> ,c gv
map <Home> <Home>
map <End> <End>
map <S-F4> <S-F4>
map <S-F3> <S-F3>
map <S-F2> <S-F2>
map <S-F1> <S-F1>
map <F1> <F1>
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
nmap <F8>:call SwitchSchemes()
nmap <silent> <Plug>RestoreWinPosn :call RestoreWinPosn()
nmap <silent> <Plug>SaveWinPosn :call SaveWinPosn()
nmap <SNR>14_WE <Plug>AlignMapsWrapperEnd
nmap <SNR>14_WS <Plug>AlignMapsWrapperStart
nnoremap <silent> <F7> :let _s=@/|:%s/\s\+$//e|:let @/=_s|:nohl
nmap <F6> :set number!
nnoremap <silent> <F4> :TlistToggle
nmap <F3> 100=
nmap <F2> w
inoremap <silent>   <BS>:call NERDComment(0, "insert")
imap 	 
imap  =CtrlXPP()
vmap ô <Plug>TwitvimVisual
let &cpo=s:cpo_save
unlet s:cpo_save
set autoindent
set backspace=2
set backupskip=/tmp/*,/private/tmp/*
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set complete=.,w,b,u,t,i,k
set completefunc=syntaxcomplete#Complete
set cpoptions=aABceFsM
set dictionary=~/.vim/templates/code.complete
set noequalalways
set errorformat=%D(in\\\ %f),%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Failure:,%A\\\ %\\\\+%\\\\d%\\\\+)\\\ Error:,%+A'%.%#'\\\ FAILED,%C%.%#(eval)%.%#,%C-e:%.%#,%C%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%C%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%C%.%#/vendor/rails/%.%#,%C\\\ %\\\\+On\\\ line\\\ #%l\\\ of\\\ %f,%CActionView::TemplateError:\\\ compile\\\ error,%Ctest_%.%#(%.%#):%#,%C%.%#\\\ [%f:%l]:,%C\\\ \\\ \\\ \\\ [%f:%l:%.%#,%C\\\ \\\ \\\ \\\ %f:%l:%.%#,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#]:,%C\\\ \\\ \\\ \\\ \\\ %f:%l:%.%#,%Z%f:%l:\\\ %#%m,%Z%f:%l:,%C%m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#.rb:%\\\\d%\\\\+:in\\\ `load':\\\ %f:%l:\\\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ syntax\\\ error\\\\\\,\ %m,%.%#:in\\\ `require':in\\\ `require':\\\ %f:%l:\\\ %m,%-G%.%#/lib/gems/%\\\\d.%\\\\d/gems/%.%#,%-G%.%#/lib/ruby/%\\\\d.%\\\\d/%.%#,%-G%.%#/vendor/rails/%.%#,%-G%.%#%\\\\d%\\\\d:%\\\\d%\\\\d:%\\\\d%\\\\d%.%#,%-G%\\\\s%#from\\\ %.%#,%f:%l:\\\ %#%m,%-G%.%#
set expandtab
set fileencodings=ucs-bom,utf-8,latin1
set formatoptions=tcql
set grepprg=grep\ -nH\ $*
set helplang=en
set hidden
set history=1000
set hlsearch
set iskeyword=@,48-57,_,192-255,:,$
set laststatus=2
set lazyredraw
set listchars=tab:>-,trail:.
set modelines=0
set omnifunc=javascriptcomplete#CompleteJS
set paste
set shell=bash
set shiftwidth=2
set showmatch
set softtabstop=2
set statusline=%f\ %=%-14.(%l,%c%V%)\ %<%P%h%1*%m%r%w%0*
set tabstop=2
set textwidth=78
set title
set viminfo='20,\"50
set wildmenu
set wildmode=list:longest
set window=1
set winminheight=0
set winwidth=1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/.vim/colors
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +41 ~/site/branches/forums_2_0/site/app/views/review/show.rhtml
badd +21 ~/site/branches/forums_2_0/site/app/views/product/_tabs.html.erb
badd +1 ~/site/branches/forums_2_0/site/app/views/common/_product_thumb.rhtml
badd +1289 ~/site/branches/forums_2_0/site/app/helpers/application_helper.rb
badd +23 ~/site/branches/forums_2_0/site/app/helpers/layout_helper.rb
badd +32 ~/site/branches/forums_2_0/site/public/javascripts/application.js
badd +217 ~/.vim/vimrc/.vimrc
badd +9 ~/.vim/plugin/colorswitch.vim
badd +17 ~/src/viewpoints/site/trunk/site/app/views/footer/_content_mygofer.rhtml
badd +21 ~/src/viewpoints/site/trunk/site/app/views/content/about_us_mygofer.rhtml
badd +1 transparent_2.vim
badd +51 ~/.vim/indent/javascript.vim
badd +6 good_colors
badd +583 ~/.vim/doc/ps_color.txt
badd +400 ps_color.vim
badd +50 ~/.vim/test_files/javascript.js
badd +1 11
badd +22 automation.vim
badd +41 inkpot.vim
args transparent_2.vim
edit ~/site/branches/forums_2_0/site/app/views/product/_tabs.html.erb
set splitbelow splitright
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
argglobal
let s:cpo_save=&cpo
set cpo&vim
nmap <buffer> gf <Plug>RailsTabFind
nmap <buffer> f <Plug>RailsSplitFind
nmap <buffer> [f <Plug>RailsAlternate
nmap <buffer> ]f <Plug>RailsRelated
nmap <buffer> gf <Plug>RailsFind
map <buffer> <silent> <Plug>RailsTabFind :RTfind
map <buffer> <silent> <Plug>RailsVSplitFind :RVfind
map <buffer> <silent> <Plug>RailsSplitFind :RSfind
map <buffer> <silent> <Plug>RailsFind :REfind
map <buffer> <silent> <Plug>RailsRelated :R
map <buffer> <silent> <Plug>RailsAlternate :A
let &cpo=s:cpo_save
unlet s:cpo_save
setlocal noarabic
setlocal autoindent
setlocal autoread
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=:0,p0,t0
setlocal cinwords=if,else,while,do,for,switch,case
setlocal comments=:#
setlocal commentstring=<!--%s-->
setlocal complete=.,w,b,u,t,i,k
setlocal completefunc=syntaxcomplete#Complete
setlocal nocopyindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'xml'
setlocal filetype=xml
endif
setlocal foldcolumn=0
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
set foldlevel=1
setlocal foldlevel=1
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=0
setlocal include=^\\s*\\<\\(load\\|w*require\\)\\>
setlocal includeexpr=RailsIncludeexpr()
setlocal indentexpr=XmlIndentGet(v:lnum,1)
setlocal indentkeys=o,O,*<Return>,<>>,<<>,/,{,}
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255,:,$
setlocal keymap=
setlocal keywordprg=ri
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=rake
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
setlocal nonumber
setlocal numberwidth=4
setlocal omnifunc=xmlcomplete#CompleteTags
setlocal path=.,~/site/branches/forums_2_0/site,~/site/branches/forums_2_0/site/app/controllers,~/site/branches/forums_2_0/site/app,~/site/branches/forums_2_0/site/app/models,~/site/branches/forums_2_0/site/app/helpers,~/site/branches/forums_2_0/site/config,~/site/branches/forums_2_0/site/lib,~/site/branches/forums_2_0/site/vendor,~/site/branches/forums_2_0/site/vendor/plugins/*/lib,~/site/branches/forums_2_0/site/test/unit,~/site/branches/forums_2_0/site/test/functional,~/site/branches/forums_2_0/site/test/integration,~/site/branches/forums_2_0/site/app/apis,~/site/branches/forums_2_0/site/app/services,~/site/branches/forums_2_0/site/test,/vendor/plugins/*/test,~/site/branches/forums_2_0/site/vendor/rails/*/lib,~/site/branches/forums_2_0/site/vendor/rails/*/test,~/site/branches/forums_2_0/site/spec,~/site/branches/forums_2_0/site/spec/*,~/site/branches/forums_2_0/site/app/views/product,~/site/branches/forums_2_0/site/app/views,~/site/branches/forums_2_0/site/public,~/site/branches/forums_2_0/site,~/site/branches/forums_2
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal nosmartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=
setlocal suffixesadd=.rb,.rhtml,.erb,.rxml,.builder,.rjs,.mab,.liquid,.haml,.dryml,.css,.js,.yml,.csv,.rake,.sql,.html,.xml
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'xml'
setlocal syntax=xml
endif
setlocal tabstop=2
setlocal tags=./tags,./TAGS,tags,TAGS,~/site/branches/forums_2_0/site/tags,~/site/branches/forums_2_0/site/.tags
setlocal textwidth=0
setlocal thesaurus=
setlocal nowinfixheight
setlocal nowinfixwidth
setlocal wrap
setlocal wrapmargin=0
let s:l = 41 - ((40 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
41
normal! 0
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=1 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . s:sx
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
