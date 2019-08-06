set rtp+=/usr/local/opt/fzf

if &compatible
  set nocompatible
endif
set rtp+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  call dein#load_toml('~/.config/nvim/dein.toml', {'lazy': 0})
  call dein#load_toml('~/.config/nvim/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
if dein#check_install()
  call dein#install()
endif
filetype plugin indent on
syntax enable

"====================================================================================
" Configuration
"====================================================================================
" for Vim
set encoding=utf-8
scriptencoding utf-8

map \ <leader>
set fileencodings=utf-8,sjis
set textwidth=0                 " 一行に長い文章を書いていても自動折り返しを
set nobackup                    " バックアップ取らない
set noswapfile                  " スワップファイル作らない
set hidden                      " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start  " バックスペースでなんでも消せるように
set whichwrap=b,s,h,l,<,>,[,]   " カーソルを行頭、行末で止まらないようにする
set showcmd                     " コマンドをステータス行に表示
set showmode                    " 現在のモードを表示
set viminfo='50,<1000,s100,\"50 " viminfoファイルの設定
set modelines=0                 " モードラインは無効
set clipboard=unnamed           " yank to clipboard
set ambiwidth=double

set display=lastline
set pumheight=10
set tabpagemax=1000
set breakindent
set t_BE=
set nf=""

augroup set_fo
  " t textwidthを使ってテキストを自動折返しする。
  " c 現在のコメント指示を挿入して、textwidthを使ってコメントを自動折返しする。
  " r 挿入モードで<return>を打った後に、現在のコメント指示を自動的に挿入する。
  " o ノーマルモードで'o'、'O'を打った後に、現在のコメント指示を自動的に挿入する。
  " q 'gq'によるコメントの整形を可能にする。
  " 2 テキストの整形処理時、段落の最初の行ではなく２番目の行のインデントをそれ以降の行に対して使う。
  " v 挿入モードでVi互換の自動折返しを使う 現在の挿入モードで入力された空白でのみ折返しが行われる。
  " b 'v'と同じ、ただし空白の入力か折返しマージンの前でのみ自動折返しをする。
  " l 挿入モードでは長い行は折り返されない
  autocmd!
  autocmd FileType * setlocal fo=lmcq
augroup END

set lazyredraw
set ttyfast
set laststatus=2 " 常にステータスラインを表示
set ruler " カーソルが何行目の何列目に置かれているかを表示する
set number " 行番号を表示する
" set noequalalways " ウインドウ幅の自動調整を行わない

"====================================================================================
" 英字キーボードでVimを使っている時に、:wqを高速で入力してエラーが出てウオアア
" ア!!とならないための設定 http://goo.gl/a55YK
"====================================================================================
command! -nargs=0 Wq wq

"====================================================================================
" インデント調整
"====================================================================================
set indentkeys=!^F,o,O
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent
set smartindent
" ハイフン区切りのワードを選択しやすくする
" http://qiita.com/ponko2/items/0a14d0649f918f5e3ce7
setlocal iskeyword& iskeyword+=-

" これをしないと候補選択時に Scratch ウィンドウが開いてしまう
set completeopt=menuone

" html インデントの解除
" augroup stop_html_indent
"   autocmd!
"   autocmd FileType html :setlocal indentexpr=""
" augroup END

"====================================================================================
" Delete
"====================================================================================
nnoremap <Leader>fd :call delete(expand('%'))<CR>

"====================================================================================
" View
"====================================================================================
" Ref: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
syntax enable
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
colorscheme iceberg

"====================================================================================
" Complete
"====================================================================================
set ignorecase
set smartcase
set hlsearch
set incsearch " インクリメンタルサーチを行う
set listchars=eol:$,tab:>\ ,extends:< " listで表示される文字のフォーマットを指定する
set showmatch " 対応するカッコを強調表示
set matchtime=1
set showtabline=2
set expandtab
set tabstop<
set softtabstop=2
set shiftwidth=2
set nowrapscan " 検索をファイルの先頭へループしない
" コマンドライン補完するときに補完候補を表示する(tabで補完)
set wildmenu
set wildignore=*.jpg,*.png,*.gif,*.pdf,*.svg,*.ico,*.keep
" set wildignore+=node_modules/**,images/**,vendor/**

" for performance
set re=1
set nocursorline
set norelativenumber
set nocursorcolumn
set guicursor=
" set synmaxcol=180
" syntax sync minlines=100 maxlines=1000

" タブ幅をリセット
augroup set_tab_stop
  autocmd!
  autocmd BufNewFile,BufRead * set tabstop=2 shiftwidth=2
augroup END

" vimを使って保存時に楽をする
" http://qiita.com/katton/items/bc9720826120f5f61fc1
function! s:remove_dust()
    let cursor = getpos(".")
    " 保存時に行末の空白を除去する
    %s/\s\+$//ge
    " 保存時にtabを2スペースに変換する
    %s/\t/  /ge
    " 保存時にRuby1.8 Hashを除去する
    " %s/\([^:]\+\):\{1}\([^ :"']\+\)\s=>/\1\2:/ge
    call setpos(".", cursor)
    unlet cursor
endfunction

augroup remove_dust
  autocmd!
  autocmd BufWritePre * call <SID>remove_dust()
augroup END


"====================================================================================
" Mapping
"====================================================================================
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz
nnoremap + <C-a>
nnoremap - <C-x>

nnoremap Y y$

"-------------------------------------------
" http:/qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca/
"-------------------------------------------
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap th :tabmove -1<CR>
nnoremap tl :tabmove +1<CR>
nnoremap tc :tabclose<CR>
" nnoremap sr <C-w>r
" nnoremap s= <C-w>=
" nnoremap sw <C-w>w
" nnoremap so <C-w>|<C-w>_
nnoremap sO <C-w>=
" nnoremap sN :<C-u>bn<CR>
" nnoremap sP :<C-u>bp<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
" nnoremap sq :<C-u>q<CR>
" nnoremap sQ :<C-u>bd<CR>

" 表示行単位で行移動する
nnoremap <silent> j gj
nnoremap <silent> k gk

" Escの2回押しでハイライト消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" 強制終了
nmap <C-q><C-q> :qa!<CR>
vmap <C-q><C-q> :qa!<CR>
imap <C-q><C-q> :qa!<CR>

" redraw!
nmap <Leader>w :redraw!<CR>

" ビジュアルモードで選択したテキストで検索する
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" vimgrep コマンド後に | cw を自動的に行う
augroup auto_cw
  autocmd!
  autocmd QuickFixCmdPost *grep* cwindow
augroup END

" ヤンク、ペースト後のカーソル移動
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

"-------------------------------------------
" [Insert current filename - Vim Tips Wiki - Wikia](http://vim.wikia.com/wiki/Insert_current_filename)
"-------------------------------------------
" inserts the current filename without the extension
:inoremap <leader>fn <C-R>=expand("%:t:r")<CR>

" To keep the extension use:
" :inoremap <leader>n <C-R>=expand("%:t")<CR>

" To insert the absolute path of the directory the file is in use:
" :inoremap <leader>n <C-R>=expand("%:p:h")<CR>

" To insert the relative path of the directory the file is in use:
" :inoremap <leader>n <C-R>=expand("%:h")<CR>

"-------------------------------------------
" 自動補完
"-------------------------------------------
" inoremap , ,
imap {} {}<Left>
imap [] []<Left>
imap () ()<Left>
imap "" ""<Left>
imap '' ''<Left>
imap <> <><Left>

" 行末にセミコロン;をつけて改行
inoremap ;; <C-O>$;<CR>

" 検索パターンの入力を改善する
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"-------------------------------------------
" 画面移動
"-------------------------------------------
nnoremap <c-k> <c-w>k
nnoremap <c-j> <c-w>j
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <c-up> <c-w>k
nnoremap <c-down> <c-w>j
nnoremap <c-left> <c-w>h
nnoremap <c-right> <c-w>l


"====================================================================================
" Hack #202: 自動的にディレクトリを作成する
"====================================================================================
augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force ||
    \    input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END


"====================================================================================
" Hack #69: 簡単にカレントディレクトリを変更する
"====================================================================================
command! -nargs=? -complete=dir -bang CD  call s:ChangeCurrentDir('<args>', '<bang>')
function! s:ChangeCurrentDir(directory, bang)
    if a:directory == ''
        lcd %:p:h
    else
        execute 'lcd' . a:directory
    endif

    if a:bang == ''
        pwd
    endif
endfunction

" Change current directory.
nnoremap <silent> <Space>cd :<C-u>CD<CR>


"====================================================================================
" Hack #198: ウィンドウを開く方向を指定する
"====================================================================================
" 新しいウィンドウを下に開く
set splitbelow
" 新しいウィンドウを右に開く
set splitright


"====================================================================================
" Hack #206: 外部で変更のあったファイルを自動的に読み直す
"====================================================================================
set autoread
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END


"====================================================================================
" バッファ移動するたびに E211: File xxxx no longer available が表示されるのを抑制する
"====================================================================================
autocmd FileChangedShell * execute


"====================================================================================
" カーソル下の syntax 情報を取得する
" http://cohama.hateblo.jp/entry/2013/08/11/020849
"====================================================================================
function! s:get_syn_id(transparent)
  let synid = synID(line("."), col("."), 1)
  if a:transparent
    return synIDtrans(synid)
  else
    return synid
  endif
endfunction
function! s:get_syn_attr(synid)
  let name = synIDattr(a:synid, "name")
  let ctermfg = synIDattr(a:synid, "fg", "cterm")
  let ctermbg = synIDattr(a:synid, "bg", "cterm")
  let guifg = synIDattr(a:synid, "fg", "gui")
  let guibg = synIDattr(a:synid, "bg", "gui")
  return {
        \ "name": name,
        \ "ctermfg": ctermfg,
        \ "ctermbg": ctermbg,
        \ "guifg": guifg,
        \ "guibg": guibg}
endfunction
function! s:get_syn_info()
  let baseSyn = s:get_syn_attr(s:get_syn_id(0))
  echo "name: " . baseSyn.name .
        \ " ctermfg: " . baseSyn.ctermfg .
        \ " ctermbg: " . baseSyn.ctermbg .
        \ " guifg: " . baseSyn.guifg .
        \ " guibg: " . baseSyn.guibg
  let linkedSyn = s:get_syn_attr(s:get_syn_id(1))
  echo "link to"
  echo "name: " . linkedSyn.name .
        \ " ctermfg: " . linkedSyn.ctermfg .
        \ " ctermbg: " . linkedSyn.ctermbg .
        \ " guifg: " . linkedSyn.guifg .
        \ " guibg: " . linkedSyn.guibg
endfunction
command! SyntaxInfo call s:get_syn_info()

"====================================================================================
" c*でカーソル下のキーワードを置換
" http://miniman2011.blog55.fc2.com/blog-entry-295.html
"====================================================================================
nnoremap <expr> c* ':%s ;\<' . expand('<cword>') . '\>;'
vnoremap <expr> c* ':s ;\<' . expand('<cword>') . '\>;'

"====================================================================================
" Copy File Path/Name
"
" REF:
"   - [vim-scripts/copypath.vim: Copy current editing file path to clipboard.](https://github.com/vim-scripts/copypath.vim)
"   - [Get the name of the current file - Vim Tips Wiki - Wikia](http://vim.wikia.com/wiki/Get_the_name_of_the_current_file)
"====================================================================================
function CopyPath()
    let @*=@%
endfunction

function CopyFullPath()
    let @*=expand('%:p')
endfunction

function CopyFileName()
    let @*=expand('%:t')
endfunction

command! -nargs=0 CopyPath     call CopyPath()
command! -nargs=0 CopyFullPath call CopyFullPath()
command! -nargs=0 CopyFileName call CopyFileName()

nnoremap <leader>p :<C-u>CopyPath<CR>
nnoremap <leader>fp :<C-u>CopyFullPath<CR>
nnoremap <leader>fn :<C-u>CopyFileName<CR>
