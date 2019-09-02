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
badd +61 style.css
badd +1 term://.//24068:/bin/bash
badd +1 main.sh
badd +22 stats.sh
badd +33 single.sh
badd +460 stats.txt
badd +12 index.html
badd +99 term://.//24084:/bin/bash
badd +1 day_time.sh
badd +16 make_mkv.sh
badd +180 zero.vim
badd +21 scripts/main.sh
badd +76 http/js/script.js
badd +18 http/js/title.js
badd +39 scripts/single.sh
badd +30 scripts/backup.sh
badd +56 scripts/bracket.sh
badd +324 docs/convert.txt
badd +10 scripts/resize.sh
badd +54 scripts/stats.sh
badd +15 scripts/config.sh
badd +9 http/index.html
badd +18 scripts/day_time.sh
badd +25 scripts/parse_message.sh
badd +90 scripts/capture.sh
argglobal
silent! argdel *
set stal=2
edit scripts/config.sh
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
exe 'vert 1resize ' . ((&columns * 76 + 125) / 251)
exe 'vert 2resize ' . ((&columns * 90 + 125) / 251)
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
let s:l = 15 - ((14 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/scripts/capture.sh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 83 - ((25 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
83
normal! 015|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//24068:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 57 - ((55 * winheight(0) + 31) / 63)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
57
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
exe 'vert 1resize ' . ((&columns * 76 + 125) / 251)
exe 'vert 2resize ' . ((&columns * 90 + 125) / 251)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
tabedit ~/Projects/github/raspberry/zero/scripts/capture.sh
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
exe '1resize ' . ((&lines * 62 + 33) / 66)
exe 'vert 1resize ' . ((&columns * 83 + 125) / 251)
exe '2resize ' . ((&lines * 62 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 83 + 125) / 251)
exe '3resize ' . ((&lines * 62 + 33) / 66)
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
35,48fold
let s:l = 106 - ((36 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
106
normal! 010|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/scripts/bracket.sh
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let s:l = 35 - ((34 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
35
normal! 024|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//24084:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 137 - ((61 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
137
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
exe '1resize ' . ((&lines * 62 + 33) / 66)
exe 'vert 1resize ' . ((&columns * 83 + 125) / 251)
exe '2resize ' . ((&lines * 62 + 33) / 66)
exe 'vert 2resize ' . ((&columns * 83 + 125) / 251)
exe '3resize ' . ((&lines * 62 + 33) / 66)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
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
