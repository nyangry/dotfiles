"-------------------------------------------------------------------------------
"Init
"-------------------------------------------------------------------------------
set encoding=utf-8
set fileencodings=utf-8
set nocompatible                 " vi互換なし
"let mapleader = ","              " キーマップリーダー
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しを
set nobackup                     " バックアップ取らない
set autoread                     " 他で書き換えられたら自動で読み直す
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効
set autoindent   " 自動でインデント
set paste        " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent      " Cプログラムファイルの自動インデントを始める
autocmd FileType * setlocal formatoptions-=r "改行時にコメントを受け継がない
autocmd FileType * setlocal formatoptions-=o "改行時にコメントを受け継がない
set clipboard=unnamed,autoselect "OSのクリップボードを使用する
set mouse=a "ターミナルでマウスを使用できるようにする
set guioptions+=a
set ttymouse=xterm2
set laststatus=2 "常にステータスラインを表示
set ruler "カーソルが何行目の何列目に置かれているかを表示する
set number "行番号を表示する
syntax enable
set autoindent
set cursorline "カーソル行をハイライト

"----------------------------------------
" Vimスクリプト
"----------------------------------------
""""""""""""""""""""""""""""""
"ファイルを開いたら前回のカーソル位置へ移動
""""""""""""""""""""""""""""""
"augroup vimrcEx
"  autocmd!
"  autocmd BufReadPost *
"    \ if line("'\"") > 1 && line("'\"") <= line('$') |
"    \   exe "normal! g`\"" |
"    \ endif
"augroup END

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine ctermbg=54'


if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
" if has('unix') && !has('gui_running')
"   " ESCでキー入力待ちになる対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction
""""""""""""""""""""""""""""""
"全角スペースを表示
""""""""""""""""""""""""""""""
"コメント以外で全角スペースを指定しているので、scriptencodingと、
"このファイルのエンコードが一致するよう注意！
"強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
scriptencoding utf-8
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  "全角スペースを明示的に表示する
  silent! match ZenkakuSpace /　/
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd VimEnter,BufEnter * call ZenkakuSpace()
  augroup END
endif
""""""""""""""""""""""""""""""
"ステータスラインに文字コードやBOM、16進表示等表示
""""""""""""""""""""""""""""""

" ステータスラインの表示
  set statusline=%<     " 行が長すぎるときに切り詰める位置
  set statusline+=%r    " %r 読み込み専用フラグ
  set statusline+=%h    " %h ヘルプバッファフラグ
  set statusline+=%w    " %w プレビューウィンドウフラグ
  set statusline+=%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}  " fencとffを表示
  set statusline+=%y    " バッファ内のファイルのタイプ
  set statusline+=[%n]  " バッファ番号
  set statusline+=%m    " %m 修正フラグ
  set statusline+=\     " 空白スペース
if winwidth(0) >= 130
  set statusline+=%F    " バッファ内のファイルのフルパス
else
  set statusline+=%t    " ファイル名のみ
endif
  set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
  set statusline+=%{fugitive#statusline()}  " Gitのブランチ名を表示
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%1l   " 何行目にカーソルがあるか
  set statusline+=/
  set statusline+=%L    " バッファ内の総行数
  set statusline+=,
  set statusline+=%c    " 何列目にカーソルがあるか
  set statusline+=%V    " 画面上の何列目にカーソルがあるか
  set statusline+=\ \   " 空白スペース2個
  set statusline+=%P    " ファイル内の何％の位置にあるか

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
"jellybeans, rdark, ekvoli, revolutions, telstar
"colorscheme ekvoli
"autocmd VimEnter * :GuiColorScheme xoria256
"autocmd VimEnter * :colorscheme xoria256
set background=dark
colorscheme ir_black_256
"let g:guicolorscheme_color_table = {'bg' : 'Black'}
":hi clear CursorLine
":hi CursorLine gui=underline
"highlight CursorLine ctermbg=black guibg=black
"-------------------------------------------------------------------------------
"Complete
"-------------------------------------------------------------------------------
set hlsearch
autocmd BufWritePre * :%s/\s\+$//ge "保存時に行末の空白を除去する
set incsearch "インクリメンタルサーチを行う
set listchars=eol:$,tab:>\ ,extends:< "listで表示される文字のフォーマットを指定する
set shiftwidth=2 "シフト移動幅
set showmatch "閉じ括弧が入力されたとき、対応する括弧を表示する
set tabstop=2 "ファイル内の <Tab> が対応する空白の数
set nowrapscan "検索をファイルの先頭へループしない
"set wildignore+=Library*,Document*,Movie*,Dropbox*,Music*,Pictures*,Downloads*
"set wildignore+=*.o,*.obj,*.ps,*.eps,*.gif,*.jpeg,*.jpg,*.png,*.bmp,*.mp3,*.mp4,*.wav,*.m4a
"set wildignore+=*.strings,*.plist,*.wflow,*.olk14Folder,*.olk14DBHeader,*.olk14Contact
set wildignore+=*.DS_Store,*.pdf,*.swf,*.gif,*.jpeg,*.jpg,*.png,*.bmp,*.mp3,*.mp4,*.wav,*.m4a
set wildignore+=*.ps,*.eps,*.aux,*.dvi
set wildignore+=*.xls,*.xlsx,*.key

"-------------------------------------------------------------------------------
"Syntax Check
"-------------------------------------------------------------------------------
"Ruby
augroup rbsyntaxcheck
	autocmd!
	autocmd BufWrite *.rb w !ruby -c
augroup END

"PHP
augroup phpsyntaxcheck
	autocmd!
	autocmd BufWrite *.php w !php -l
augroup END
"-------------------------------------------------------------------------------
"Vimdiff
"-------------------------------------------------------------------------------
"Vimdiffで半角スペースを無視する
set diffopt+=iwhite
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
Bundle 'git://git.wincent.com/command-t.git'
filetype plugin indent on     " required!
"----------------------------------------
" ショートカット
"----------------------------------------
" CTRL-hjklでウインドウ移動
nnoremap <C-j> ;<C-w>j
nnoremap <C-k> ;<C-w>j
nnoremap <C-l> ;<C-w>j
nnoremap <C-h> ;<C-w>j
" タブ移動をCTRL+TABに
nnoremap <C-n> gt
nnoremap <C-b> gT
" CTRL＋Lで最終編集箇所へジャンプ
nnoremap <C-l> gl
" CTRL+wでタブ終了
"nnoremap <C-w> ZZ
" CTRL+tでファイルを開く
"nnoremap <C-t> :tabnew<CR>
"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
" CTRL + Dで :cd 入力待ちにする
nnoremap <C-d> :<C-u>cd<space>
"-------------------------------------------------------------------------------
"Plugin/command-t
"-------------------------------------------------------------------------------
let g:CommandTMaxHeight=15
nnoremap <silent> <C-f> :<C-u>CommandT <Return>
"-------------------------------------------------------------------------------
"Plugin/Unite
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
"Plugin/Neocomplcache
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



