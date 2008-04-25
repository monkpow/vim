" Vim color file
" Maintainer:   Nik Krimm
" Last Change:  Nov 10, 2007

set background=light

" First remove all existing highlighting.
hi clear
if exists("syntax_on")
    syntax reset
endif

" default groups
hi Normal			ctermfg=darkgray	ctermbg=white

"hi Cursor											
"hi CursorIM			NONE								
hi Directory			ctermfg=black



" hi DiffAdd			ctermfg=White	ctermbg=DarkCyan				
" hi DiffChange			ctermfg=Black	ctermbg=Gray					
" hi DiffDelete			ctermfg=White	ctermbg=DarkRed					
hi DiffAdd	 ctermfg=gray	ctermbg=darkblue				
hi DiffChange	 ctermfg=gray	ctermbg=darkblue				
hi DiffDelete	ctermfg=gray	ctermbg=darkblue				
hi DiffText	cterm=reverse	ctermfg=darkgray	ctermbg=white				

hi ErrorMsg			ctermfg=White	ctermbg=DarkRed					
hi VertSplit	cterm=reverse						
hi Folded	cterm=bold	ctermfg=darkgray	ctermbg=NONE				
hi FoldColumn			ctermfg=Green	ctermbg=NONE					
"hi IncSearch termfg=blue ctermbg=white					
hi LineNr			ctermfg=gray
hi ModeMsg	cterm=bold	ctermfg=White					
hi MoreMsg	cterm=bold	ctermfg=White					
hi NonText			ctermfg=NONE						
hi Question			ctermfg=Green						
hi Search	cterm=reverse	ctermfg=fg	ctermbg=NONE				
hi SpecialKey			ctermfg=green					
hi StatusLine	ctermfg=gray ctermbg=Black		 	
hi StatusLineNC	cterm=reverse	ctermfg=Gray	ctermbg=Black				
hi Title			ctermfg=green				
hi Visual	cterm=inverse	
"hi VisualNOS	cterm=bold,underline					
hi WarningMsg			ctermfg=White	ctermbg=DarkRed					
hi WildMenu	cterm=bold	ctermfg=Black	ctermbg=Yellow				
"hi Menu	
"hi Scrollbar	
"hi Tooltip	
"hi CursorLine  cterm=bold  ctermbg=lightgray
" syntax highlighting groups
hi Comment			ctermfg=gray

hi Constant			ctermfg=green					
hi String			ctermfg=blue						
hi Character			ctermfg=brown						
"hi Number
"hi Boolean
"hi Float

hi Identifier			ctermfg=blue					
hi Function			ctermfg=brown cterm=bold						

hi Statement		 ctermfg=black						
"hi Conditional
"hi Repeat
hi Label			ctermfg=darkblue						
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
hi Typedef			ctermfg=black						

hi Special			ctermfg=black						
"hi SpecialChar
hi Tag				ctermfg=green					
hi Delimiter			ctermfg=Green						
"hi SpecialComment
hi Debug			ctermfg=White	ctermbg=Black					

"hi Underlined	cterm=underline						

hi Ignore			ctermfg=DarkBlue					

hi Error			ctermfg=White	ctermbg=DarkRed					

hi Todo				ctermfg=Black	ctermbg=Gray					

