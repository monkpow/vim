" Vim indent file
" Language:     JavaScript
" Maintainer:   Nik Krimm <nkrimm@gmail.com>
" Created:      12/28/2006
" Last Change:	12/28/2006
" Version: 0.2
" URL: comming soon

" Version .02
" capture case: { } on same line (same indenting)
" Skeleton liberally borrowed from tex script written by tex indent script
" written by ?? 

" todo
" indent [\n correctly
" abstract patterns

setlocal indentexpr=GetJSIndent()
setlocal nolisp
setlocal nosmartindent
setlocal autoindent
setlocal indentkeys+=},=\\item,=\\bibitem


" Only define the function once
"if exists("*GetJSIndent") | finish
"endif



function! GetJSIndent()

  " Find a non-blank line above the current line.
  let lnum = prevnonblank(v:lnum - 1)

  " At the start of the file use zero indent.
  if lnum == 0 | return 0 
  endif

  let ind = indent(lnum)
  let line = getline(lnum)             " last line
  let cline = getline(v:lnum)          " current line

  " Do not change indentation of commented lines.
  "if line =~ '^\s*\/'
  "  return ind
  " endif

  " adding shiftwidth

  "if line =~ '^\s*)\s*{\([^}]*\)}\s*$'  " ) { return -1 } 
    ""let ind = ind + &sw 
    ""return ind 
  "endif


  if line =~ '{\s*$' || line =~ '{\s*\/' " beginning of block statements.
    let ind = ind + &sw
  elseif line =~ '([^)]*$'             " an open paren ends a line.
    let ind = ind + &sw
  elseif line =~ '{' && line =~ '}'    " capture {/* same line */}
    let ind = ind + &sw
  elseif line =~ '[\s*$'               " capture case where an array is set on separate lines
    let ind = ind + &sw
  endif


  " removing shiftwith
  if cline =~ '^\s*)'              " a closed paren starts a line.
    let ind = ind - &sw
    "elseif cline =~ '{' && cline =~ '}' 
    "  let ind = ind - &sw
  elseif cline =~ '}' " Subtract a 'shiftwidth' when a block statement ends
    let ind = ind - &sw
  elseif line =~ '(){}'  " like:  ) { return -1 } 
    let ind = ind - &sw 
  elseif line =~ '^\s*)\s*{\([^}]*\)}\s*$'  " like:  ) { return -1 } 
    let ind = ind - &sw 
  elseif cline=~ ']\s*$'                " unindent at end of array
    let ind = ind - &sw
  endif

  return ind

endfunction

