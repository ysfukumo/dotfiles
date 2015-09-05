" backupfile and swapfile path
if has("win32") || has("win64")
  set nobackup
  set noswapfile
else
  set backupdir=/tmp
  set directory=/tmp
  set notitle
endif


"----------------------------------------------------------
" undofile生成無効化
"----------------------------------------------------------
set noundofile

"----------------------------------------------------------
" クリップボード
"----------------------------------------------------------
" クリップボードの共有
set clipboard=unnamed,autoselect

"----------------------------------------------------------
" 表示関係
"----------------------------------------------------------
" タブ、改行の表示、表示文字の指定
set list
"set listchars=tab:>\ ,eol:$,trail:_,extends:<
set listchars=tab:>.,eol:$,trail:_,extends:\

" 行番号を表示
set number
" 入力中のコマンドをステータスに表示
set showcmd
" 括弧入力時の対応する括弧を表示
set showmatch
" 対応する括弧の表示時間を2にする
set matchtime=2
" ステータスラインに表示する情報の指定
" set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%l/%L:%p%%>
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%c><%l/%L:%p%%>

"----------------------------------------------------------
" インデント
"----------------------------------------------------------
" オートインデントを無効にする
"set noautoindent
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2
" タブを挿入するとき、代わりに空白を使わない
"set noexpandtab
" タブを挿入するとき、代わりに空白を使う
set expandtab

"----------------------------------------------------------
" tagファイル読み込み
"----------------------------------------------------------
set tags+=~/tags/java6
set tags+=~/tags/android

"----------------------------------------------------------
" golang 
"----------------------------------------------------------
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
set completeopt=menu,preview

" vim-go-extra
autocmd FileType go autocmd BufWritePre <buffer> Fmt


"----------------------------------------------------------
" キーマップ
"----------------------------------------------------------
" _vimrc / _gvimrcを開く ( space + v / space + g )
"nnoremap <Space>v :<C-u>tabedit $MYVIMRC<CR>
nnoremap <Space>v :<C-u>tabedit ~/dotfiles/_vimrc<CR>
"nnoremap <Space>g :<C-u>tabedit $MYGVIMRC<CR>
nnoremap <Space>g :<C-u>tabedit ~/dotfiles/_gvimrc<CR>

" memoファイルを開く
command! Todo tabedit ~/memo/todo.md

" 一時ファイルを開く
command! -nargs=1 -complete=filetype Tmp edit ~/memo/tmp.<args>
command! -nargs=1 -complete=filetype Temp edit ~/memo/tmp.<args>

"----------------------------------------------------------
" autocmd
"----------------------------------------------------------
autocmd BufNewFile,BufRead *.{md,markdown} set filetype=markdown

"----------------------------------------------------------
" quickrun
"----------------------------------------------------------
" quickrun設定の初期化
let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
" markdown用設定(for mac) Markedでプレビュー
let g:quickrun_config.markdown = {
    \ 'outputter' : 'null',
    \ 'command'   : 'open',
    \ 'cmdopt'    : '-a',
    \ 'args'      : 'Marked',
    \ 'exec'      : '%c %o %a %s',
    \ }

"----------------------------------------------------------
" vim-indent-guides
"----------------------------------------------------------
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=3
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4


"----------------------------------------------------------
" NeoBundle
"----------------------------------------------------------
set nocompatible
filetype off

if has('vim_starting')
    if has("win32") || has("win64")
        set rtp+=~/vimfiles/neobundle.vim
        set rtp+=~/vimfiles/after
        call neobundle#rc(expand('~/vimfiles/bundle/'))
    else
        set rtp+=~/.vim/neobundle.vim
        call neobundle#rc(expand('~/.vim/bundle/'))
    endif
endif

" NeoBundle
NeoBundle 'https://github.com/Shougo/unite.vim'
NeoBundle 'https://github.com/Shougo/neomru.vim'
NeoBundle 'https://github.com/thinca/vim-ref'
NeoBundle 'https://github.com/thinca/vim-quickrun'
NeoBundle 'https://github.com/Shougo/vimfiler.vim'
NeoBundle 'https://github.com/itchyny/lightline.vim'
NeoBundle 'https://github.com/nathanaelkane/vim-indent-guides'
NeoBundle 'https://github.com/mattn/vim-cheat'
NeoBundle 'https://github.com/ctrlpvim/ctrlp.vim'
NeoBundle 'https://github.com/nixprime/cpsm'
NeoBundle 'https://github.com/vim-jp/vim-go-extra'
NeoBundle 'https://github.com/NLKNguyen/papercolor-theme'


NeoBundle 'https://github.com/Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }

filetype plugin indent on

"----------------------------------------------------------
" lightline
"----------------------------------------------------------
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"----------------------------------------------------------
" タブページの設定(tabpage)
"----------------------------------------------------------
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2 " 常にタブラインを表示

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor
" t1 で1番左のタブ、t2 で1番左から2番目のタブにジャンプ

map <silent> [Tag]c :tablast <bar> tabnew<CR>
" tc 新しいタブを一番右に作る
map <silent> [Tag]x :tabclose<CR>
" tx タブを閉じる
map <silent> [Tag]n :tabnext<CR>
" tn 次のタブ
map <silent> [Tag]p :tabprevious<CR>
" tp 前のタブ


"----------------------------------------------------------
" ウィンドウ分割関連設定(Ctrl-w)
"----------------------------------------------------------
nnoremap ss <C-W>s  "上下分割(split)
nnoremap sv <C-W>v  "左右分割(vertical)
nnoremap sw <C-W>w  "次のウィンドウに移動(window)
nnoremap sc <C-W>c  "現在のウィンドウを閉じる(close)
nnoremap so <C-W>o  "現在のウィンドウ以外を閉じる(only)

nnoremap sj <C-W>j  "下のウィンドウに移動
nnoremap sk <C-W>k  "上のウィンドウに移動
nnoremap <silent> sh <C-W>h:call <SID>good_width()<CR>  "左のウィンドウへ移動
nnoremap <silent> sl <C-W>l:call <SID>good_width()<Cr>  "右のウィンドウへ移動
" ウィンドウの幅をいい感じにする
function! s:good_width()
  if winwidth(0) < 84
    vertical resize 84
  endif
endfunction

" ウィンドウの縦幅を大きくする/小さくする
nnoremap + <C-W>+
nnoremap - <C-W>-
" ウィンドウの横幅を大きくする/小さくする
nnoremap ) <C-W>> 
nnoremap ( <C-W><LT>

" ウィンドウの大きさを最大化する
function! s:big()
    wincmd _ | wincmd |
endfunction
nnoremap <silent> s<CR> :<C-u>call <SID>big()<CR> " 最大化
nnoremap s0 1<C-W>_ " 最小化
nnoremap s. <C-W>=  " 全部同じ大きさにする


"----------------------------------------------------------
" foldの設定
"----------------------------------------------------------
set foldlevel=100 "Don't autofold anything

"----------------------------------------------------------
" Unite.vimの設定
"----------------------------------------------------------
" 起動時にインサートモードで開始
let g:unite_enable_start_insert = 1

" The prefix key.
nnoremap    [unite]   <Nop>
nmap    <Space>u [unite]

" unite.vim keymap
let g:unite_source_history_yank_enable =1
nnoremap <silent> [unite]u :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]g :<C-u>Unite<Space>grep<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> [unite]c :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,vr :UniteResume<CR>
" vinarise
let g:vinarise_enable_auto_detect = 1 
" unite-build map
nnoremap <silent> ,vb :Unite build<CR>
nnoremap <silent> ,vcb :Unite build:!<CR>
nnoremap <silent> ,vch :UniteBuildClearHighlight<CR>

nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_encoding = 'utf-8'
endif

" unite-grepの便利キーマップ
" Ctrl-vで単語選択後、/gで検索
vnoremap /g y:Unite grep::-iRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>


"----------------------------------------------------------
" CtrlPの設定
"----------------------------------------------------------
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_user_command = 'files -p %s'

