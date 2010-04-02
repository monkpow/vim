let SwitchSchemesFiles = globpath("$VIMRUNTIME,$HOME/.vim","colors/*.vim")
let SwitchSchemesIndex = 0
function! SwitchSchemes()
  let sep="\n"
  if g:SwitchSchemesIndex == -1
    let g:SwitchSchemesIndex=0
  endif
  exe "source " . NextElement(g:SwitchSchemesFiles, sep, g:SwitchSchemesIndex)
  let g:SwitchSchemesIndex = NextIndex(g:SwitchSchemesFiles, sep, g:SwitchSchemesIndex + 1)
endfunction
nmap <F1>:call SwitchSchemes():echo g:color_name
