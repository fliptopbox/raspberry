let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Projects/github/raspberry/zero
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 script.js
badd +21 style.css
badd +25 main.sh
badd +0 term://.//8499:/bin/bash
argglobal
silent! argdel *
edit script.js
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe 'vert 1resize ' . ((&columns * 82 + 83) / 166)
exe '2resize ' . ((&lines * 42 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 83 + 83) / 166)
exe '3resize ' . ((&lines * 3 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 83 + 83) / 166)
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
38,64fold
67,69fold
72,85fold
89,99fold
102,111fold
89
normal! zo
let s:l = 96 - ((71 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
96
normal! 029|
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
let s:l = 28 - ((27 * winheight(0) + 21) / 42)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
28
normal! 04|
lcd ~/Projects/github/raspberry/zero
wincmd w
argglobal
edit term://.//8499:/bin/bash
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
let s:l = 199 - ((2 * winheight(0) + 1) / 3)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
199
normal! 030|
lcd ~/Projects/github/raspberry/zero
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 82 + 83) / 166)
exe '2resize ' . ((&lines * 42 + 24) / 48)
exe 'vert 2resize ' . ((&columns * 83 + 83) / 166)
exe '3resize ' . ((&lines * 3 + 24) / 48)
exe 'vert 3resize ' . ((&columns * 83 + 83) / 166)
tabnext 1
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
