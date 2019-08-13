let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Projects/github/raspberry/zero
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +144 script.js
badd +61 style.css
badd +1 term://.//16704:/bin/bash
badd +41 main.sh
badd +22 stats.sh
badd +33 single.sh
badd +460 stats.txt
badd +12 index.html
badd +1 term://.//16719:/bin/bash
badd +46 day_time.sh
badd +16 make_mkv.sh
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
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 78 + 125) / 251)
exe 'vert 2resize ' . ((&columns * 88 + 125) / 251)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
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
25,90fold
108,109fold
112,121fold
125,185fold
112,185fold
112,185fold
112,185fold
112,185fold
25
normal! zo
108
normal! zo
112
normal! zo
112
normal! zo
112
normal! zo
112
normal! zo
112
normal! zo
125
normal! zo
let s:l = 41 - ((34 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
41
normal! 046|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/day_time.sh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 46 - ((33 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
46
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//16704:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 144 - ((61 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
144
normal! 022|
lcd ~/Projects/github/raspberry/zero
wincmd w
exe 'vert 1resize ' . ((&columns * 78 + 125) / 251)
exe 'vert 2resize ' . ((&columns * 88 + 125) / 251)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
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
edit term://.//16719:/bin/bash
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
