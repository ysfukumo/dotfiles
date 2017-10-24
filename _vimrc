if has('vim_starting')
  if !isdirectory(expand('~/var/vim/swap'))
    echo 'install vim-dir...'
    call system('mkdir -p ~/var/vim/swap')
    call system('mkdir -p ~/var/vim/backup')
    call system('mkdir -p ~/var/vim/undo')
  end
endif

" backupfile and swapfile path
if has("win32") || has("win64")
  set directory=~/var/vim/swap
  set backupdir=~/var/vim/backup
  set undodir=~/var/vim/undo
  set viminfo+=n~/var/vim/info
else
  set directory=~/var/vim/swap
  set backupdir=~/var/vim/backup
  set undodir=~/var/vim/undo
  set viminfo+=n~/var/vim/info
endif


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
set statusline=%n\:%y%F\ \|%{(&fenc!=''?&fenc:&enc).'\|'.&ff.'\|'}%m%r%=<%c><%l/%L:%p%%>

"----------------------------------------------------------
" インデント
"----------------------------------------------------------
" オートインデントを無効にする
set noautoindent
" タブが対応する空白の数
set tabstop=2
" タブやバックスペースの使用等の編集操作をするときに、タブが対応する空白の数
set softtabstop=2
" インデントの各段階に使われる空白の数
set shiftwidth=2
" タブを挿入するとき、代わりに空白を使わない
set noexpandtab

"----------------------------------------------------------
" golang 
"----------------------------------------------------------
""set rtp+=$GOROOT/misc/vim
"exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim")
"set completeopt=menu,preview
"
"" vim-go-extra
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

"----------------------------------------------------------
" キーマップ
"----------------------------------------------------------
" _vimrc / _gvimrcを開く ( space + v / space + g )
nnoremap <Space>v :<C-u>tabedit ~/dotfiles/_vimrc<CR>
nnoremap <Space>g :<C-u>tabedit ~/dotfiles/_gvimrc<CR>

"----------------------------------------------------------
" VimPlug
"----------------------------------------------------------
if has('vim_starting')
  set rtp+=~/var/vim/plugged/vim-plug
  if !isdirectory(expand('~/var/vim/plugged/vim-plug'))
    echo 'install vim-plug...'
    call system('mkdir -p ~/var/vim/plugged/vim-plug')
    call system('git clone https://github.com/junegunn/vim-plug.git ~/var/vim/plugged/vim-plug/autoload')
  end
endif

call plug#begin('~/.vim/plugged')
  Plug 'junegunn/vim-plug',
        \ {'dir': '~/.vim/plugged/vim-plug/autoload'}
  Plug 'https://github.com/thinca/vim-ref'
  Plug 'https://github.com/thinca/vim-quickrun'
  Plug 'https://github.com/itchyny/lightline.vim'
  Plug 'https://github.com/ctrlpvim/ctrlp.vim'
  Plug 'https://github.com/nixprime/cpsm'
  Plug 'https://github.com/NLKNguyen/papercolor-theme'
  Plug 'https://github.com/fatih/vim-go'
call plug#end()

"----------------------------------------------------------
" CtrlPの設定
"----------------------------------------------------------
let g:ctrlp_match_func = {'match': 'cpsm#CtrlPMatch'}
let g:ctrlp_user_command = 'files -p %s'

