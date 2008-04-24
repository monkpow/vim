"--------------------------------------------------------------------------
"
" Vim script to launch/control browsers.
"
" Currently supported browsers:
"  - Mozilla  (remote [new window / new tab] / launch)
"  - Netscape (remote [new window] / launch)
"     The remote control for either of these will probably default to
"     mozilla if both are running.
"  - Opera    (remote [new window / new tab] / launch)
"  - Lynx     (Under the current TTY if not running the GUI, or a new xterm
"              window if DISPLAY is set.)
"
" TODO:
"
"  Support more browsers?
"   - links  (text browser)
"   - w3m    (text browser)
"
"  If I support multiple text browsers, defaulting to lynx if the the GUI
"  isn't available may be undesirable.
"
"  Note: Various browsers such as galeon, nautilus, phoenix, &c use the
"  same HTML rendering engine as mozilla, so supporting them isn't as
"  important.
"   
"  The code is a mess.  Oh well.
"
"--------------------------------------------------------------------------


if exists("*LaunchBrowser")
	finish
endif

let s:NetscapeRemoteCmd = system("which netscape-remote")
if v:shell_error != 0
	let s:NetscapeRemoteCmd = system("which netscape")
endif
if v:shell_error != 0
	let s:NetscapeRemoteCmd = system("which mozilla")
endif
let s:NetscapeRemoteCmd = substitute(s:NetscapeRemoteCmd, "\n$", "", "")


" Usage:
"  :call LaunchBrowser([0123],[012])
"    The first argument is which browser to launch:
"      0 - Netscape
"      1 - Opera
"      2 - Lynx
"      3 - Mozilla
"    The second argument is whether to launch a new window:
"      0 - No
"      1 - Yes
"      2 - New Tab (or new window if the browser doesn't provide a way to
"                   open a new tab)
"
" Return value:
"  0 - Failure (No browser was launched/controlled.)
"  1 - Success
function! LaunchBrowser(which,new)

	let file = expand("%:p")

	if ((! strlen($DISPLAY)) || a:which == 2 )
		echohl Todo | echo "Launching lynx..." | echohl None

		if (has("gui_running") || a:new) && strlen($DISPLAY)
			call system("xterm -T Lynx -e lynx " . file . " &")

			if shell_error
				echohl ErrorMsg | echo "Unable to launch lynx in an xterm." | echohl None
				return 0
			endif
		else
			sleep 1
			execute "!lynx " . file

			if shell_error
				echohl ErrorMsg | echo "Unable to launch lynx." | echohl None
				return 0
			endif
		endif

		return 1
	endif


	if (a:which == 1)
		if a:new == 2
			echohl Todo | echo "Opening new Opera tab..." | echohl None
			call system("sh -c \"trap '' HUP; opera -remote 'openURL(file://" . file . ",new-page)' &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
				return 0
			endif
		elseif a:new
			echohl Todo | echo "Opening new Opera window..." | echohl None
			call system("sh -c \"trap '' HUP; opera -remote 'openURL(file://" . file . ",new-window)' &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
				return 0
			endif
		else
			echohl Todo | echo "Sending remote command to Opera..." | echohl None
			call system("sh -c \"trap '' HUP; opera " . file . " &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
				return 0
			endif
		endif

		return 1
	endif

	let windows = system("xwininfo -root -children | egrep \"[Nn]etscape|[Mm]ozilla\"; return 0")
	if windows =~? 'mozilla'
		let MozillaRunning = 1
	else
		let MozillaRunning = 0
	endif
	if windows =~? 'netscape'
		let NetscapeRunning = 1
	else
		let NetscapeRunning = 0
	endif

	if (a:which == 3)
		if ! MozillaRunning
			echohl Todo | echo "Launching mozilla, please wait..." | echohl None
			call system("sh -c \"trap '' HUP; mozilla " . file . " &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to launch mozilla." | echohl None
				return 0
			endif
		else
			if a:new == 2
				echohl Todo | echo "Mozilla is running, opening new tab..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ",new-tab)\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			elseif a:new
				echohl Todo | echo "Mozilla is running, opening new window..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ",new-window)\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			else
				echohl Todo | echo "Mozilla is running, issuing remote command..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ")\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			endif
		endif

		return 1
	endif

	if (a:which == 0)
		if ! NetscapeRunning
			echohl Todo | echo "Launching netscape, please wait..." | echohl None
			call system("sh -c \"trap '' HUP; netscape " . file . " &\"")

			if shell_error
				echohl ErrorMsg | echo "Unable to launch netscape." | echohl None
				return 0
			endif
		else
			if a:new
				echohl Todo | echo "Netscape is running, opening new window..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ",new-window)\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			else
				echohl Todo | echo "Netscape is running, issuing remote command..." | echohl None
				call system(s:NetscapeRemoteCmd . " -remote \"openURL(file://" . file . ")\"")

				if shell_error
					echohl ErrorMsg | echo "Unable to issue remote command." | echohl None
					return 0
				endif
			endif
		endif
		return 1
	endif

	echohl ErrorMsg | echo "Unknown browser ID." | echohl None
	return 0
endfunction

" vim: set ts=2 sw=2 ai nu tw=75 fo=croq2:
