" MangleImageTag() - updates an <IMG>'s width and height tags.
"
" Requirements:
"       VIM 6 or later
"
" Copyright (C) March 2004  Christian J. Robinson <infynity@onewest.net>
"
" Based on "mangleImageTag" by Devin Weaver <ktohg@tritarget.com>
"
" This program is free software; you can  redistribute  it  and/or  modify  it
" under the terms of the GNU General Public License as published by  the  Free
" Software Foundation; either version 2 of the License, or  (at  your  option)
" any later version.
"
" This program is distributed in the hope that it will be useful, but  WITHOUT
" ANY WARRANTY; without  even  the  implied  warranty  of  MERCHANTABILITY  or
" FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General  Public  License  for
" more details.
"
" You should have received a copy of the GNU General Public License along with
" this program; if not, write to the Free Software Foundation, Inc., 59 Temple
" Place - Suite 330, Boston, MA 02111-1307, USA.
"
" RCS info: ---------------------------------------------------------------{{{
" $Id: MangleImageTag.vim,v 1.1.1.1 2006/12/29 04:51:20 nkrimm Exp $
" $Log: MangleImageTag.vim,v $
" Revision 1.1.1.1  2006/12/29 04:51:20  nkrimm
" starting vim module
"
" Revision 1.2  2004/03/22 10:04:24  infynity
" Update the right tag if more than one IMG tag appears on the line.
"
" Revision 1.1  2004/03/22 05:58:34  infynity
" Initial revision
" -------------------------------------------------------------------------}}}

if exists("*MangleImageTag")
	finish
endif

function! MangleImageTag() "{{{1
	let start_linenr = line('.')
	let end_linenr = start_linenr
	let col = col('.') - 1
	let line = getline(start_linenr)

	if line !~? '<img'
		echohl ErrorMsg
		echomsg "Line doesn't contain an image tag."
		echohl None

		return
	endif

	" Get the rest of the tag if we have a partial tag:
	if line =~? '<img[^>]*$'
		while line =~? '<img\_[^>]*$'
			let end_linenr = end_linenr + 1
			let line = line . "\n" . getline(end_linenr)
		endwhile
	endif

	" Make sure we modify the right tag if more than one is on the line:
	if line[col] != '<'
		let tmp = strpart(line, 0, col)
		let tagstart = strridx(tmp, '<')
	else
		let tagstart = col
	endif
	let savestart = strpart(line, 0, tagstart)
	let tag = strpart(line, tagstart)
	let tagend = stridx(tag, '>') + 1
	let saveend = strpart(tag, tagend)
	let tag = strpart(tag, 0, tagend)

	if tag[0] != '<' || col > strlen(savestart . tag) - 1
		echohl ErrorMsg
		echomsg "Cursor isn't on an IMG tag."
		echohl None

		return
	endif

	if tag =~? "src=\\(\".\\{-}\"\\|'.\\{-}\'\\)"
		let src = substitute(tag, ".\\{-}src=\\([\"']\\)\\(.\\{-}\\)\\1.*", '\2', '')
		if tag =~# 'src'
			let case = 0
		else
			let case = 1
		endif
	else
		echohl ErrorMsg
		echomsg "Image src not specified in the tag."
		echohl None

		return
	endif

	let size = s:ImageSize(src)
	if size == ''
		return
	endif
	let width = strpart(size, 0, stridx(size, ' '))
	let height = strpart(size, stridx(size, ' ') + 1)

	if tag =~? "height=\\(\"\\d\\+\"\\|'\\d\\+\'\\|\\d\\+\\)"
		let tag = substitute(tag,
			\ "\\c\\(height=\\)\\([\"']\\=\\)\\(\\d\\+\\)\\(\\2\\)",
			\ '\1\2' . height . '\4', '')
	else
		let tag = substitute(tag,
			\ "\\csrc=\\([\"']\\)\\(.\\{-}\\|.\\{-}\\)\\1",
			\ '\0 ' . (case ? 'HEIGHT' : 'height') . '=' . height, '')
	endif

	if tag =~? "width=\\(\"\\d\\+\"\\|'\\d\\+\'\\|\\d\\+\\)"
		let tag = substitute(tag,
			\ "\\c\\(width=\\)\\([\"']\\=\\)\\(\\d\\+\\)\\(\\2\\)",
			\ '\1\2' . width . '\4', '')
	else
		let tag = substitute(tag,
			\ "\\csrc=\\([\"']\\)\\(.\\{-}\\|.\\{-}\\)\\1",
			\ '\0 ' . (case ? 'WIDTH' : 'width') . '=' . width, '')
	endif

	let line = savestart . tag . saveend
	silent exe 'normal :' . start_linenr . ',' . end_linenr . "change\n" . line . "\n."
endfunction

function! s:ImageSize(image) "{{{1
	let ext = fnamemodify(a:image, ':e')

	if ext !~? 'png\|gif\|jpg'
		echohl ErrorMsg
		echomsg "Image type not recognized: " . tolower(ext)
		echohl None
		return ''
	endif

	if filereadable(a:image)
		let ldsave=&lazyredraw
		set lazyredraw

		new
		silent exe '$read ' . a:image
		go

		setlocal buftype=nofile noswapfile

		if ext ==? 'png'
			let size = s:SizePng()
		elseif ext ==? 'gif'
			let size = s:SizeGif()
		elseif ext ==? 'jpg'
			let size = s:SizeJpg()
		endif

		bwipe!

		let &lazyredraw=ldsave
	else
		echohl ErrorMsg
		echomsg "Can't read file: " . a:image
		echohl None

		return ''
	endif

	return size
endfunction

function! s:SizeGif() "{{{1
	"if search("^GIF.......") == 0
	if search('^\CGIF\_.\_.\_.\_.\_.\_.\_.') == 0
		echohl ErrorMsg
		echomsg "Malformed GIF file."
		echohl None
		return ''
	endif

	let saveww=&ww
	set ww+=l

	let savea=@a
	let saveb=@b
	normal 6l"ay2l2l"by2l
	let height=@a[1] . @a[0]
	let width=@b[1] . @b[0]
	let @a=savea
	let @b=saveb

	let &ww=saveww

	let width = s:Vec(width)
	let height = s:Vec(height)

	return width . ' ' . height
endfunction

function! s:SizeJpg() "{{{1
	"if search("\xff\xc0.......") == 0
	if search("\xff\xc0\\_.\\_.\\_.\\_.\\_.\\_.\\_.") == 0
		echohl ErrorMsg
		echomsg "Malformed JPEG file."
		echohl None
		return ''
	endif

	let saveww=&ww
	set ww+=l

	let savea=@a
	let saveb=@b
	normal 5l"ay2l2l"by2l
	let height=@a
	let width=@b
	let @a=savea
	let @b=saveb

	let &ww=saveww

	let width = s:Vec(width)
	let height = s:Vec(height)

	return width . ' ' . height
endfunction

function! s:SizePng() "{{{1
	"if search('\CIHDR........') == 0
	if search('\CIHDR\_.\_.\_.\_.\_.\_.\_.\_.') == 0
		echohl ErrorMsg
		echomsg "Malformed PNG file."
		echohl None
		return ''
	endif

	let saveww=&ww
	set ww+=l

	let savea=@a
	let saveb=@b
	normal 4l"ay4l4l"by4l
	let width=@a
	let height=@b
	let @a=savea
	let @b=saveb

	let &ww=saveww

	let width = s:Vec(width)
	let height = s:Vec(height)

	return width . ' ' . height
endfunction

function! s:Vec(str) "{{{1
	let len = strlen(a:str)
	let n = ''
	let i = 0
	while i < len
		" Gah, Vim can be lame sometimes. char2nr() on a NUL returns "10".
		" This means the image size might not be right if one of the
		" characters really is a newline.  :(
		let tmp = char2nr(a:str[i])
		let n = n * 256 + (tmp == 10 ? 0 : tmp)
		let i = i + 1
	endwhile

	return n
endfunction

" vim:ts=4:sw=4:
" vim600:fdm=marker:fdc=2:cms=\ \"%s:
