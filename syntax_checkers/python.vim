if exists("loaded_python_syntax_checker")
    finish
endif
let loaded_python_syntax_checker = 1

"bail if the user doesnt have pyflakes installed
if !executable("pyflakes")
    finish
endif

function! SyntaxCheckers_python_GetLocList()
    let makeprg = 'pyflakes '.shellescape(expand('%')).' -r no'
    let errorformat = '%E%f:%l: could not compile,%-Z%p^,%W%f:%l: %m,%-G%.%#'

    let pyflakes_errors = SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })
    
    let makeprg = 'pylint '.shellescape(expand('%')).' -r no'
    let errorformat = '%E%f:%l: could not compile,%-Z%p^,%W%f:%l: %m,%-G%.%#'

    let pylint_errors = SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })

    let makeprg = 'pep8 '.shellescape(expand('%'))
    let errorformat = '%E%f:%l: could not compile,%-Z%p^,%W%f:%l: %m,%-G%.%#'

    let pep8_errors = SyntasticMake({ 'makeprg': makeprg, 'errorformat': errorformat })

    let errors = pyflakes_errors + pylint_errors + pep8_errors

    for i in errors
        if i['type'] ==# 'E'
            let i['text'] = "Syntax error"
        endif
    endfor

    return errors
endfunction
