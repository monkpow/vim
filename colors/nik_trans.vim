" Vim color file
" Maintainer:   Sir Raorn <raorn@altlinux.ru>
" Last Change:  Nov 10, 2002
" URL:		http://hell.binec.ru/

" This color scheme uses "transparent" background (dark dark blue in gvim)
" Looks really nice when vim (console) started in transparent aterm
" But gvim is good either
set background=dark

" First remove all existing highlighting.
hi clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="transparent"

" default groups
hi Normal			ctermfg=gray	ctermbg=black

"hi Cursor											
"hi CursorIM			NONE								
hi Directory			ctermfg=White					



" hi DiffAdd			ctermfg=White	ctermbg=DarkCyan				
" hi DiffChange			ctermfg=Black	ctermbg=Gray					
" hi DiffDelete			ctermfg=White	ctermbg=DarkRed					
hi DiffAdd	 ctermfg=white	ctermbg=darkblue				
hi DiffChange	 ctermfg=white	ctermbg=darkblue				
hi DiffDelete	ctermfg=white	ctermbg=darkblue				
hi DiffText	cterm=reverse	ctermfg=darkgray	ctermbg=white				

hi ErrorMsg			ctermfg=White	ctermbg=DarkRed					
hi VertSplit	cterm=reverse						
hi Folded	cterm=bold	ctermfg=darkgray	ctermbg=NONE				
hi FoldColumn			ctermfg=Green	ctermbg=NONE					
hi IncSearch			ctermfg=White	ctermbg=Black					
hi LineNr			ctermfg=gray
hi ModeMsg	cterm=bold	ctermfg=White					
hi MoreMsg	cterm=bold	ctermfg=White					
hi NonText			ctermfg=NONE						
hi Question			ctermfg=Green						
hi Search	cterm=reverse	ctermfg=fg	ctermbg=NONE				
hi SpecialKey			ctermfg=LightRed					
hi StatusLine	cterm=bold,reverse ctermfg=white ctermbg=Black		 	
hi StatusLineNC	cterm=reverse	ctermfg=Gray	ctermbg=Black				
hi Title			ctermfg=LightGreen				
hi Visual	cterm=inverse	ctermfg=White	ctermbg=DarkGray			
hi VisualNOS	cterm=bold,underline					
hi WarningMsg			ctermfg=White	ctermbg=DarkRed					
hi WildMenu	cterm=bold	ctermfg=Black	ctermbg=Yellow				
"hi Menu	
"hi Scrollbar	
"hi Tooltip	

" syntax highlighting groups
hi Comment			ctermfg=darkblue

hi Constant			ctermfg=LightGreen					
hi String			ctermfg=lightgreen						
hi Character			ctermfg=brown						
"hi Number
"hi Boolean
"hi Float

hi Identifier			ctermfg=LightCyan					
hi Function			ctermfg=brown cterm=bold						

hi Statement			ctermfg=red						
"hi Conditional
"hi Repeat
hi Label			ctermfg=White						
hi Operator			ctermfg=Green						
"hi Keyword
hi Exception			ctermfg=Black	ctermbg=DarkRed					

hi PreProc			ctermfg=DarkGreen					
"hi Include
"hi Define
"hi Macro
"hi PreCondit

hi Type				ctermfg=gray						
"hi StorageClass
"hi Structure
hi Typedef			ctermfg=Red						

hi Special			ctermfg=Red						
"hi SpecialChar
hi Tag				ctermfg=LightGreen					
hi Delimiter			ctermfg=Green						
"hi SpecialComment
hi Debug			ctermfg=White	ctermbg=Black					

hi Underlined	cterm=underline						

hi Ignore			ctermfg=DarkBlue					

hi Error			ctermfg=White	ctermbg=DarkRed					

hi Todo				ctermfg=Black	ctermbg=Gray					

