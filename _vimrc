"-------------------------------------------------------------------------------
"Init
"-------------------------------------------------------------------------------
set nocompatible                 " vi互換なし
set encoding=utf-8
set fileencodings=utf-8
"let mapleader = ","              " キーマップリーダー
map ¥ <leader>
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
"set paste        " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
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

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
autocmd BufWritePre * :%s/\t/ /ge

" y9で行末までヤンク
nmap y9 y$
" y0で行頭までヤンク
nmap y0 y^

" タブ文字、行末など不可視文字を表示する
" set list
" listで表示される文字のフォーマットを指定する
" set listchars=eol:~,tab:>\ ,extends:<
" Tab、行末の半角スペースを明示的に表示する
" set listchars=tab:^\ ,trail:~
set listchars=tab:>\ ,trail:~

set autoindent   " 自動でインデント
set smartindent  " 新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set cindent
"set indentexpr

set cursorline "カーソル行をハイライト
" これをしないと候補選択時に Scratch ウィンドウが開いてしまう
set completeopt=menuone

"----------------------------------------
" Vimスクリプト
"----------------------------------------
"挿入モード時、ステータスラインの色を変更
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
inoremap , ,
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
"行末にセミコロン;をつけて改行
inoremap ;; <C-O>$;<CR>
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
"colorscheme FadetoGrey
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
set expandtab
set tabstop=2 "ファイル内の <Tab> が対応する空白の数
"タブ幅をリセット
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2
set nowrapscan "検索をファイルの先頭へループしない
"set wildignore+=Library*,Document*,Movie*,Dropbox*,Music*,Pictures*,Downloads*
"set wildignore+=*.o,*.obj,*.ps,*.eps,*.gif,*.jpeg,*.jpg,*.png,*.bmp,*.mp3,*.mp4,*.wav,*.m4a
"set wildignore+=*.strings,*.plist,*.wflow,*.olk14Folder,*.olk14DBHeader,*.olk14Contact
set wildignore+=*.DS_Store,*.pdf,*.swf,*.gif,*.jpeg,*.jpg,*.png,*.bmp,*.mp3,*.mp4,*.wav,*.m4a
set wildignore+=*.ps,*.eps,*.aux,*.dvi
set wildignore+=*.xls,*.xlsx,*.key
"-------------------------------------------------------------------------------
"Syntax
"-------------------------------------------------------------------------------
"jQuery
"au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
"au BufRead,BufNewFile *.js set ft=javascript syntax=jquery
"JSON
au! BufRead,BufNewFile *.json set filetype=json
"HTML5
au BufRead,BufNewFile *.html set ft=html syntax=html5
"CSS3
au BufRead,BufNewFile *.css set ft=css syntax=css3


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
"----------------------------------------
" ショートカット
"----------------------------------------
"表示行単位で行移動する
nnoremap <silent> j gj
nnoremap <silent> k gk
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
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"-------------------------------------------------------------------------------
"Compiler
"-------------------------------------------------------------------------------
autocmd FileType javascript :compiler gjslint
autocmd QuickfixCmdPost make copen

"-------------------------------------------------------------------------------
"Vundle
"-------------------------------------------------------------------------------
filetype off

set rtp+=~/.vim/bundle/vundle/ "vundleのディレクトリ
call vundle#rc()
Bundle 'gmarik/vundle'
Bundle 'thinca/vim-quickrun'
Bundle 'thinca/vim-guicolorscheme'
Bundle 'tpope/vim-fugitive'
Bundle 'Shougo/unite.vim'
Bundle 'Shougo/vimfiler'
Bundle 'Lokaltog/vim-powerline'
"Bundle 'Shougo/vimproc'
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'tpope/vim-surround'
" vim-surroundを.で繰り返しできようにする
Bundle 'tpope/vim-repeat'
Bundle 'Shougo/vimshell'
Bundle 'git://git.wincent.com/command-t.git'
"Gist
Bundle 'mattn/gist-vim'
Bundle 'mattn/webapi-vim'
"eregex.vim : vimの正規表現をrubyやperlの正規表現な入力でできる :%S/perlregex/
Bundle 'eregex.vim'
"整形ツール
Bundle 'Align'
" フィルタリングと整形
Bundle 'godlygeek/tabular'
"Syntax javascript
Bundle 'jelera/vim-javascript-syntax'
"Indent javascript
Bundle 'pangloss/vim-javascript'
"Syntax Less
Bundle 'groenewege/vim-less'
"Syntax Coffee Script
Bundle 'kchmck/vim-coffee-script'
filetype plugin indent on     " required!
"-------------------------------------------------------------------------------
"Plugin/command-t
"-------------------------------------------------------------------------------
"let g:CommandTMaxHeight=15
"デフォルトはworksディレクトリを検索する
"nnoremap <silent> <C-f> :<C-u>CommandT ~/works<Return>

"-------------------------------------------------------------------------------
"Plugin/Vimfiler
"-------------------------------------------------------------------------------
nnoremap <silent> <C-f> :<C-u>VimFiler -split -simple -winwidth=50 -no-quit<Return>
function! s:git_root_dir()
    if(system('git rev-parse --is-inside-work-tree') == "true\n")
        return ':VimFiler ' . system('git rev-parse --show-cdup') . '\<CR>'
    else
        echoerr '!!!current directory is outside git working tree!!!'
    endif
endfunction
nnoremap <expr><Leader>fg <SID>git_root_dir()

"-------------------------------------------------------------------------------
"Plugin/Powerline
"-------------------------------------------------------------------------------
let g:Powerline_symbols = 'fancy'

"-------------------------------------------------------------------------------
"Plugin/eregex
"-------------------------------------------------------------------------------
"nnoremap / :M/
"nnoremap ? :M?
"nnoremap ,/ /
"nnoremap ,? ?
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
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
"-------------------------------------------------------------------------------
"Plugin/Neocomplcache
"-------------------------------------------------------------------------------
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum keyword length.
let g:neocomplcache_min_keyword_length = 0
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 0
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 1
" 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
let g:neocomplcache_enable_auto_select = 1

"シンタックス補完を無効に
"let g:neocomplcache_plugin_disable = {
"  \ 'syntax_complete' : 1,
"  \ }

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
 \ 'default' : '',
 \ 'php' : $HOME . '/.vim/dict/php.dict',
 \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
  \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"カーソルより後のキーワードパターンを認識。
"h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
"修正するときにかなり便利。
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif

"スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
smap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-o>D"
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

"vim標準のキーワード補完を置き換える
inoremap <expr><C-n> neocomplcache#manual_keyword_complete()

" SuperTab like snippets behavior.
"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" 単語入力中だけ補完候補を出す
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
" 現在のファイルのキーワード
"inoremap <expr><C-h> pumvisible() ? "\<C-x>\<C-n>" : "\<C-h>"
" 'dictionary'のキーワード
"inoremap <expr><C-h> pumvisible() ? "\<C-x>\<C-k>" : "\<C-h>"
" 編集中と外部参照しているファイルのキーワード
"inoremap <expr><C-h> pumvisible() ? "\<C-x>\<C-i>" : "\<C-h>"
" オムニ補完
"inoremap <expr><C-h> pumvisible() ? "\<C-x>\<C-o>" : "\<C-h>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby set omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"-------------------------------------------------------------------------------
"Plugin/tabular [ :Tab /| etc..]
"-------------------------------------------------------------------------------
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

"------------------------------------
" Align
"------------------------------------
" Alignを日本語環境で使用するための設定
let g:Align_xstrlen = 3
