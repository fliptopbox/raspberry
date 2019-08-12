let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Projects/github/raspberry/zero
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +1 script.js
badd +41 style.css
badd +1 term://.//13053:/bin/bash
badd +22 main.sh
badd +17 stats.sh
badd +30 single.sh
badd +460 stats.txt
badd +12 index.html
badd +1 term://.//13068:/bin/bash
argglobal
silent! argdel *
set stal=2
edit script.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 83 + 125) / 251)
exe '2resize ' . ((&lines * 1 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 83 + 125) / 251)
exe '3resize ' . ((&lines * 60 + 32) / 65)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
exe 'vert 4resize ' . ((&columns * 83 + 125) / 251)
argglobal
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
47,75fold
78,91fold
94,103fold
107,137fold
94,137fold
94,137fold
94
normal! zo
94
normal! zo
94
normal! zo
107
normal! zo
let s:l = 94 - ((61 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
94
normal! 024|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/style.css
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 47 - ((23 * winheight(0) + 0) / 1)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
47
normal! 031|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/main.sh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 29 - ((28 * winheight(0) + 30) / 60)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
29
normal! 04|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//13053:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 62 - ((61 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
62
normal! 01|
lcd ~/Projects/github/raspberry/zero
wincmd w
3wincmd w
exe 'vert 1resize ' . ((&columns * 83 + 125) / 251)
exe '2resize ' . ((&lines * 1 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 83 + 125) / 251)
exe '3resize ' . ((&lines * 60 + 32) / 65)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
exe 'vert 4resize ' . ((&columns * 83 + 125) / 251)
tabnew
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 125 + 125) / 251)
exe 'vert 2resize ' . ((&columns * 125 + 125) / 251)
argglobal
enew
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//13068:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 62 - ((61 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
62
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
exe 'vert 1resize ' . ((&columns * 125 + 125) / 251)
exe 'vert 2resize ' . ((&columns * 125 + 125) / 251)
tabnext 1
set stal=1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
