"-------------------------------------------------------------------------------
"Init
"-------------------------------------------------------------------------------
set encoding=utf-8
set fileencoding=utf-8
set nocompatible                 " vi互換なし
let mapleader = ","              " キーマップリーダー
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しを
"set backupdir=$HOME/.vim/backup  "バックアップファイルを作るディレクトリ
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
"set directory=$HOME/.vim/buffer  "スワップファイル用のディレクトリ
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効
set autoindent   " 自動でインデント
"set paste        " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める
autocmd FileType * setlocal formatoptions-=ro "改行時にコメントを受け継がない
set clipboard+=unnamed "OSのクリップボードを使用する
set mouse=a "ターミナルでマウスを使用できるようにする
set guioptions+=a
set ttymouse=xterm2
set clipboard=unnamed "ヤンクした文字は、システムのクリップボードに入れる
set laststatus=2 "常にステータスラインを表示
set ruler "カーソルが何行目の何列目に置かれているかを表示する
set number "行番号を表示する
syntax enable
set autoindent
set cursorline "カーソル行をハイライト
set hlsearch "検索結果をハイライト
set cursorline "カーソル行をハイライト
set hlsearch "検索結果をハイライト
"-------------------------------------------------------------------------------
"自動補完
"-------------------------------------------------------------------------------
inoremap , ,<Space>
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>
inoremap < <><LEFT>
inoremap ` ``<LEFT>
"検索パターンの入力を改善する
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
"-------------------------------------------------------------------------------
"View
"-------------------------------------------------------------------------------
set t_Co=256
"wombat, ir_black, candy, h2u_black, zen, zenburn, jellybeans, wombat256mod, rdark, ap_dark8, molokai
colorscheme jellybeans
"autocmd VimEnter * :GuiColorScheme xoria256
let g:guicolorscheme_color_table = {'bg' : 'Black', 'fg' : 'Grey'}
:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black
"-------------------------------------------------------------------------------
"Complete
"-------------------------------------------------------------------------------
"キーワードハイライトのキャンセル（ESC2）
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
autocmd BufWritePre * :%s/\s\+$//ge "保存時に行末の空白を除去する
set incsearch "インクリメンタルサーチを行う
set listchars=eol:$,tab:>\ ,extends:< "listで表示される文字のフォーマットを指定する
set shiftwidth=4 "シフト移動幅
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する
set tabstop=4 "ファイル内の <Tab> が対応する空白の数
set nowrapscan "検索をファイルの先頭へループしない
