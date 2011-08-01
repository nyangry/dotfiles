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
"全角スペースを　で表示
highlight JpSpace cterm=underline ctermfg=Blue guifg=Blue
au BufRead,BufNew * match JpSpace /　/
" CTRL-hjklでウインドウ移動
nnoremap <C-j> ;<C-w>j
nnoremap <C-k> ;<C-w>j
nnoremap <C-l> ;<C-w>j
nnoremap <C-h> ;<C-w>j
" タブ移動をCTRL+TABに
nnoremap <C-n> gt
nnoremap <C-b> gT
" CTRL+wでタブ終了
nnoremap <C-w> ZZ
" CTRL+tでファイルを開く
nnoremap <C-t> :tabnew<CR>
"-------------------------------------------------------------------------------
"-------------------------------------------------------------------------------
"自動補完
"-------------------------------------------------------------------------------
inoremap , ,<Space>
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"inoremap < <><LEFT>
"inoremap ` ``<LEFT>
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
"-------------------------------------------------------------------------------
"Vundle
"-------------------------------------------------------------------------------
set nocompatible
filetype off

set rtp+=~/dotfiles/vimfiles/vundle.git/	"vundleのディレクトリ
call vundle#rc()
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-guicolorscheme'
Bundle 'tpope/vim-fugitive'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/vimshell'
filetype plugin indent on     " required!
"-------------------------------------------------------------------------------
"Unite
"-------------------------------------------------------------------------------
"バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
"ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
"レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
"最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
"常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
"全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
" 新しいウィンドウで開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q
"-------------------------------------------------------------------------------
"Neocomplcache
"-------------------------------------------------------------------------------
"neocomplcacheを起動時に有効化する設定です
let g:neocomplcache_enable_at_startup = 1
"neocomplcacheのsmart case機能を有効化します
"smart caseは'smartcase'と同様に、大文字が入力されるまで大文字小文字の区別を無視するという機能です。
let g:neocomplcache_enable_smart_case = 1
"こちらは_区切りの補完を有効化します
let g:neocomplcache_enable_underbar_completion = 1
"シンタックスをキャッシュするときの最小文字長を3にしています。デフォルトでは4です
let g:neocomplcache_min_syntax_length = 3
"ファイルタイプ毎にneocomplcacheのディクショナリを設定することができます。
"neocomplcacheは'dictionary'も見ますが、こちらを優先します。
"g:neocomplcache_dictionary_filetype_listsはcontext
"filetypeでも参照できるので、できればこちらを設定するべきです
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'default' : '',
	\ 'php' : $HOME . '/.vim/dict',
		\ }
"キーワードパターンの設定です。 neocomplcacheが対応していない独自の言語を使いたい場合は、これを変更しないといけません。 let g:neocomplcache_keyword_patterns['default']を変更しているのは、 デフォルトが\k\+となっていて、日本語も収集してしまう仕様が個人的に好きではないからです。
if !exists('g:neocomplcache_keyword_patterns')
	let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"<C-k>でスニペットの展開をできるようにします。<C-k>が取られてしまうのが気に入らない場合は、 後述するneocomplcache#sources#snippets_complete#expandable()を使ったほうが良いでしょう。 smapも同時に設定しないと、デフォルト値が選択されているときに展開やジャンプがされません。
imap <C-k> <Plug>(neocomplcache_snippets_expand)
"補完候補のなかから、共通する部分を補完します。ちょうど、シェルの補完のような動作です。
inoremap <expr><C-l> neocomplcache#complete_common_string()
"<C-h>や<BS>を押したときに確実にポップアップを削除します。
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
"現在選択している候補を確定します。
inoremap <expr><C-y> neocomplcache#close_popup()
"現在選択している候補をキャンセルし、ポップアップを閉じます
inoremap <expr><C-e> neocomplcache#cancel_popup()



