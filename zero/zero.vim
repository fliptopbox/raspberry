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
badd +1 term://.//24595:/bin/bash
badd +41 main.sh
badd +22 stats.sh
badd +33 single.sh
badd +460 stats.txt
badd +12 index.html
badd +1 term://.//24611:/bin/bash
badd +1 day_time.sh
badd +16 make_mkv.sh
badd +180 zero.vim
badd +63 scripts/main.sh
badd +76 http/js/script.js
badd +18 http/js/title.js
badd +39 scripts/single.sh
badd +2 scripts/backup.sh
badd +50 scripts/bracket.sh
badd +324 docs/convert.txt
badd +26 scripts/resize.sh
badd +4 scripts/stats.sh
badd +0 scripts/config.sh
badd +0 http/index.html
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
wincmd _ | wincmd |
split
1wincmd k
wincmd w
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
exe '1resize ' . ((&lines * 10 + 32) / 65)
exe 'vert 1resize ' . ((&columns * 83 + 125) / 251)
exe '2resize ' . ((&lines * 51 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 83 + 125) / 251)
exe '3resize ' . ((&lines * 31 + 32) / 65)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
exe '4resize ' . ((&lines * 30 + 32) / 65)
exe 'vert 4resize ' . ((&columns * 83 + 125) / 251)
exe 'vert 5resize ' . ((&columns * 83 + 125) / 251)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=4
setlocal fen
let s:l = 9 - ((8 * winheight(0) + 5) / 10)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
9
normal! 035|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/scripts/main.sh
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=4
setlocal fen
31
normal! zo
let s:l = 35 - ((13 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
35
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/scripts/resize.sh
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=4
setlocal fen
let s:l = 10 - ((9 * winheight(0) + 15) / 31)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
10
normal! 033|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit ~/Projects/github/raspberry/zero/scripts/stats.sh
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=4
setlocal fen
let s:l = 11 - ((10 * winheight(0) + 15) / 30)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//24595:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 1062 - ((61 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1062
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 10 + 32) / 65)
exe 'vert 1resize ' . ((&columns * 83 + 125) / 251)
exe '2resize ' . ((&lines * 51 + 32) / 65)
exe 'vert 2resize ' . ((&columns * 83 + 125) / 251)
exe '3resize ' . ((&lines * 31 + 32) / 65)
exe 'vert 3resize ' . ((&columns * 83 + 125) / 251)
exe '4resize ' . ((&lines * 30 + 32) / 65)
exe 'vert 4resize ' . ((&columns * 83 + 125) / 251)
exe 'vert 5resize ' . ((&columns * 83 + 125) / 251)
tabedit ~/Projects/github/raspberry/zero/http/index.html
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
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=4
setlocal fen
let s:l = 1 - ((0 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//24611:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 31 - ((30 * winheight(0) + 31) / 62)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
31
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
