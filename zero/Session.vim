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
badd +1 term://.//11966:/bin/bash
badd +1 main.sh
badd +22 stats.sh
badd +33 single.sh
badd +460 stats.txt
badd +12 index.html
badd +1 term://.//12021:/bin/bash
badd +1 day_time.sh
badd +16 make_mkv.sh
badd +180 zero.vim
badd +78 scripts/main.sh
badd +76 http/js/script.js
badd +18 http/js/title.js
badd +39 scripts/single.sh
badd +2 scripts/backup.sh
badd +56 scripts/bracket.sh
badd +324 docs/convert.txt
badd +10 scripts/resize.sh
badd +4 scripts/stats.sh
badd +13 scripts/config.sh
badd +9 http/index.html
badd +18 scripts/day_time.sh
argglobal
silent! argdel *
set stal=2
edit scripts/main.sh
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
exe 'vert 1resize ' . ((&columns * 50 + 83) / 166)
exe 'vert 2resize ' . ((&columns * 59 + 83) / 166)
exe 'vert 3resize ' . ((&columns * 55 + 83) / 166)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=4
setlocal fml=1
setlocal fdn=4
setlocal fen
let s:l = 54 - ((25 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
54
normal! 0
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
let s:l = 31 - ((30 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
31
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//11966:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 45 - ((44 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
45
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
exe 'vert 1resize ' . ((&columns * 50 + 83) / 166)
exe 'vert 2resize ' . ((&columns * 59 + 83) / 166)
exe 'vert 3resize ' . ((&columns * 55 + 83) / 166)
tabedit ~/Projects/github/raspberry/zero/scripts/main.sh
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 82 + 83) / 166)
exe 'vert 2resize ' . ((&columns * 83 + 83) / 166)
argglobal
setlocal fdm=indent
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=4
setlocal fml=1
setlocal fdn=4
setlocal fen
35
normal! zo
63
normal! zo
64
normal! zo
let s:l = 34 - ((33 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
34
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//12021:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 183 - ((44 * winheight(0) + 22) / 45)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
183
normal! 0
lcd ~/Projects/github/raspberry/zero
wincmd w
exe 'vert 1resize ' . ((&columns * 82 + 83) / 166)
exe 'vert 2resize ' . ((&columns * 83 + 83) / 166)
tabnext 2
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
