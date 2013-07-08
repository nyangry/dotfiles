"====================================================================================
" 基本設定 
"====================================================================================
set backupskip=/tmp/*,/private/tmp/* " tmpの中ではバックアップスクリプトを作成しない（crontab等用）
set nocompatible                 " vi互換なし
set encoding=utf-8
set fileencodings=utf-8
" let mapleader = ","              " キーマップリーダー
map ¥ <leader>
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しを
set nobackup                     " バックアップ取らない
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set formatoptions=lmoq           " テキスト整形オプション，マルチバイト系を追加
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効
" set paste        " ペースト時にautoindentを無効に(onにするとautocomplpop.vimが動かない)
autocmd FileType * setlocal formatoptions-=r " 改行時にコメントを受け継がない
autocmd FileType * setlocal formatoptions-=o " 改行時にコメントを受け継がない
set clipboard=unnamed,autoselect " OSのクリップボードを使用する
" set mouse=a " ターミナルでマウスを使用できるようにする
" set guioptions+=a
set ttymouse=xterm2
" set clipboard+=unnamed
" set clipboard+=autoselect
set laststatus=2 " 常にステータスラインを表示
set ruler " カーソルが何行目の何列目に置かれているかを表示する
set number " 行番号を表示する
set noequalalways " ウインドウ幅の自動調整を行わない
syntax enable

" ビジュアルモードで選択したテキストで検索する
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v,'\/'),"\n",'\\n','g')<CR><CR>

"====================================================================================
" 英字キーボードでVimを使っている時に、:wqを高速で入力してエラーが出てウオアア
" ア!!とならないための設定 http://goo.gl/a55YK
"====================================================================================
command! -nargs=0 Wq wq

"====================================================================================
" インデント調整
"====================================================================================
setlocal indentkeys=!^F,o,O
setlocal expandtab
setlocal tabstop<
setlocal softtabstop=2
setlocal shiftwidth=2
setlocal autoindent

set cursorline " カーソル行をハイライト
" これをしないと候補選択時に Scratch ウィンドウが開いてしまう
set completeopt=menuone

" html インデントの解除
au FileType html :setlocal indentexpr=""

"====================================================================================
" Vimスクリプト
"====================================================================================
" 挿入モード時、ステータスラインの色を変更
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

" Rename
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

" Rename
nnoremap <Leader>fd :call delete(expand('%'))<CR>

"====================================================================================
" 全角スペースを表示
"====================================================================================
" コメント以外で全角スペースを指定しているので、scriptencodingと、
" このファイルのエンコードが一致するよう注意！
" 強調表示されない場合、ここでscriptencodingを指定するとうまくいく事があります。
scriptencoding utf-8
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
  " 全角スペースを明示的に表示する
  silent! match ZenkakuSpace /　/
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd VimEnter,BufEnter * call ZenkakuSpace()
  augroup END
endif


"====================================================================================
" 自動補完
"====================================================================================
inoremap , , 
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" 行末にセミコロン;をつけて改行
inoremap ;; <C-O>$;<CR>
" 検索パターンの入力を改善する
cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

"====================================================================================
" View
"====================================================================================
set t_Co=256
" set background=dark
colorscheme ir_black

" nmap <Right> :bnext <CR>
" nmap <Left> :bprev <CR>
" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

nnoremap # g#
nnoremap g# #
nnoremap * g*
nnoremap g* *
"====================================================================================
" Complete
"====================================================================================
set smartcase
set hlsearch
" autocmd BufWritePre * :%s/\s\+$//ge "保存時に行末の空白を除去する
set incsearch " インクリメンタルサーチを行う
set listchars=eol:$,tab:>\ ,extends:< " listで表示される文字のフォーマットを指定する
set showmatch " 閉じ括弧が入力されたとき、対応する括弧を表示する
set expandtab
set tabstop<
set softtabstop=2
set shiftwidth=2
" タブ幅をリセット
au BufNewFile,BufRead * set tabstop=2 shiftwidth=2
set nowrapscan " 検索をファイルの先頭へループしない
" set wildignore+=Library*,Document*,Movie*,Dropbox*,Music*,Pictures*,Downloads*
" set wildignore+=*.o,*.obj,*.ps,*.eps,*.gif,*.jpeg,*.jpg,*.png,*.bmp,*.mp3,*.mp4,*.wav,*.m4a
" set wildignore+=*.strings,*.plist,*.wflow,*.olk14Folder,*.olk14DBHeader,*.olk14Contact
" set wildignore+=*.DS_Store,*.pdf,*.swf,*.gif,*.jpeg,*.jpg,*.png,*.bmp,*.mp3,*.mp4,*.wav,*.m4a
" set wildignore+=*.ps,*.eps,*.aux,*.dvi
" set wildignore+=*.xls,*.xlsx,*.key
" コマンドライン補完するときに補完候補を表示する(tabで補完)
set wildmenu


"====================================================================================
" Syntax
"====================================================================================
" JSON
au! BufRead,BufNewFile *.json set filetype=json
" HTML5
au BufRead,BufNewFile *.html set ft=html syntax=html5
" CSS3
au BufRead,BufNewFile *.css set ft=css syntax=css3
" Gemfile
au BufRead,BufNewFile Gemfile set ft=ruby
" rb
au BufRead,BufNewFile *.rb set ft=ruby


"====================================================================================
" Haml Compile 
"====================================================================================
" augroup hamlcompile
"  autocmd!
"  autocmd BufWrite *.haml w !haml % %.html 
" augroup END


"====================================================================================
" ショートカット
"====================================================================================
" 表示行単位で行移動する
nnoremap <silent> j gj
nnoremap <silent> k gk
" " CTRL+sでrsyncを叩く
" nmap <Leader>r<CR> :! /Users/admin/code/sync_rep3.sh<CR>
" Escの2回押しでハイライト消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" q:、q/、q? は無効化
nnoremap q: <NOP>
nnoremap q/ <NOP>
nnoremap q? <NOP>

"====================================================================================
" Hack #55: 正規表現のメタ文字の扱いを制御する
"====================================================================================
nnoremap / /\v
nnoremap ? ?\v

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
" Hack #181: ジャンクファイルを生成する 
"====================================================================================
command! -nargs=0 JunkFile call s:open_junk_file()
function! s:open_junk_file()
  let l:junk_dir = $HOME . '/.vim_junk'. strftime('/%Y/%m')
  if !isdirectory(l:junk_dir)
    call mkdir(l:junk_dir, 'p')
  endif

  let l:filename = input('Junk Code: ', l:junk_dir.strftime('/%Y-%m-%d-%H%M%S.'))
  if l:filename != ''
    execute 'edit ' . l:filename
  endif
endfunction
nmap <C-n> :JunkFile<CR>

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
" Hack #205: 複数行をコメントアウトする
"====================================================================================
" Comment or uncomment lines from mark a to mark b.
function! CommentMark(docomment, a, b)
  if !exists('b:comment')
    let b:comment = CommentStr() . ' '
  endif
  if a:docomment
    exe "normal! '" . a:a . "_\<C-V>'" . a:b . 'I' . b:comment
  else
    exe "'".a:a.",'".a:b . 's/^\(\s*\)' . escape(b:comment,'/') . '/\1/e'
  endif
endfunction

" Comment lines in marks set by g@ operator.
function! DoCommentOp(type)
  call CommentMark(1, '[', ']')
endfunction

" Uncomment lines in marks set by g@ operator.
function! UnCommentOp(type)
  call CommentMark(0, '[', ']')
endfunction

" Return string used to comment line for current filetype.
function! CommentStr()
  if &ft == 'cpp' || &ft == 'java' || &ft == 'php' || &ft == 'javascript'
    return '//'
  elseif &ft == 'vim'
    return '"'
  elseif &ft == 'python' || &ft == 'perl' || &ft == 'sh' || &ft == 'R' || &ft == 'ruby' || &ft == 'yaml' || &ft == 'coffee'
    return '#'
  elseif &ft == 'lisp'
    return ';'
  elseif &ft == 'haml'
    return '-#'
  endif
  return ''
endfunction

nnoremap <Leader>c <Esc>:set opfunc=DoCommentOp<CR>g@
nnoremap <Leader>C <Esc>:set opfunc=UnCommentOp<CR>g@
vnoremap <Leader>c <Esc>:call CommentMark(1,'<','>')<CR>
vnoremap <Leader>C <Esc>:call CommentMark(0,'<','>')<CR>

"====================================================================================
" Hack #206: 外部で変更のあったファイルを自動的に読み直す
"====================================================================================
set autoread                     
augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END


"====================================================================================
" vimの連続コピペ http://goo.gl/1Lp9Q
"====================================================================================
vnoremap <silent> <C-p> "0p<CR>


"====================================================================================
" vimから言語を指定してDash.appを呼び出す http://goo.gl/Hu4DI
"====================================================================================
function! s:dash(...)
  let ft = &filetype
  if &filetype == 'python'
    let ft = ft.'2'
  endif
  let ft = ft.':'
  let word = len(a:000) == 0 ? input('Dash search: ', ft.expand('<cword>')) : ft.join(a:000, ' ')
  call system(printf("open dash://'%s'", word))
endfunction
command! -nargs=* Dash call <SID>dash(<f-args>)


"====================================================================================
" Compiler
"====================================================================================
autocmd FileType javascript :compiler gjslint
autocmd QuickfixCmdPost make copen


"====================================================================================
" Neobundle
"====================================================================================
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim/
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

"----------------------------------------------------------
" basic
"----------------------------------------------------------
NeoBundle 'Lokaltog/vim-powerline'

NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
" NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler.vim'

NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-endwise'
" NeoBundle 'scrooloose/nerdtree'
" taglist
NeoBundle 'vim-scripts/taglist.vim'
" % による対応括弧へのカーソル移動機能を拡張
NeoBundle 'jwhitley/vim-matchit'
" fakeclip
NeoBundle 'kana/vim-fakeclip'
" Copy File Path/Name
NeoBundle 'vim-scripts/copypath.vim'
" Gist
NeoBundle 'mattn/gist-vim'
NeoBundle 'mattn/webapi-vim'
" 整形ツール
NeoBundle 'h1mesuke/vim-alignta'
" Octopress
NeoBundle 'glidenote/octoeditor.vim'
" vim-rooter
NeoBundle 'airblade/vim-rooter'
" インデント対応表示
NeoBundle 'nathanaelkane/vim-indent-guides'

" Window size
NeoBundle 'jimsei/winresizer'

" colorscheme
" NeoBundle 'ujihisa/unite-colorscheme'

" source ssh
NeoBundle 'Shougo/unite-ssh'


"----------------------------------------------------------
" ctags
"----------------------------------------------------------
" NeoBundle 'szw/vim-tags'
NeoBundle 'tsukkee/unite-tag'

"----------------------------------------------------------
" Ruby
"----------------------------------------------------------
NeoBundle 'kana/vim-textobj-user' "vim-textobj-rubyが依存
NeoBundle 'rhysd/vim-textobj-ruby'
NeoBundle 'rhysd/unite-ruby-require.vim'
NeoBundle 'Shougo/neocomplcache-rsense'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'vim-ruby/vim-ruby'

"----------------------------------------------------------
" Rails
"----------------------------------------------------------
NeoBundle 'tpope/vim-rails'
" NeoBundle 'vim-scripts/dbext.vim'
NeoBundle 'taichouchou2/alpaca_complete'
NeoBundle 'taichouchou2/unite-reek'
NeoBundle 'taichouchou2/unite-rails_best_practices'
NeoBundle 'romanvbabenko/rails.vim' " unite-rails-best-practiceが依存

"----------------------------------------------------------
" indent
"----------------------------------------------------------
NeoBundle 'jiangmiao/simple-javascript-indenter'

"----------------------------------------------------------
" Syntax
"----------------------------------------------------------
NeoBundle 'tpope/vim-haml'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'taichouchou2/html5.vim'
" NeoBundle 'jelera/vim-javascript-syntax'
" NeoBundle 'taichouchou2/vim-javascript'
" NeoBundle 'rickeyvisinski-kanban/vim-jquery'
" NeoBundle 'paulyg/Vim-PHP-Stuff'
" NeoBundle 'vim-scripts/mathml.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'cakebaker/scss-syntax.vim'
NeoBundle 'kchmck/vim-coffee-script'

"----------------------------------------------------------
" Complete
"----------------------------------------------------------
NeoBundle 'teramako/jscomplete-vim'

" NeoBundle 'vimtaku/vim-mlh'
" NeoBundle 'tyru/skk.vim'


filetype plugin indent on     " required!



"====================================================================================
" Plugin Settings
"====================================================================================
"----------------------------------------------------------
" Powerline
"----------------------------------------------------------
let g:Powerline_symbols = 'fancy'


"----------------------------------------------------------
" tags
"----------------------------------------------------------
" let g:vim_tags_project_tags_command = "ctags -f .tags -R {OPTIONS} {DIRECTORY} 2>/dev/null &"                                                                                                    
" let g:vim_tags_gems_tags_command = "ctags -R -f .Gemfile.lock.tags `bundle show --paths` 2>/dev/null &"
" 
" set tags+=.tags
" set tags+=.Gemfile.lock.tags

" http://qiita.com/items/4398a19c05ad4861af85
au BufNewFile, BufRead Gemfile setl filetype=Gemfile
au BufWritePost Gemfile call vimproc#system('rbenv ctags')

"----------------------------------------------------------
" Unite
"----------------------------------------------------------

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
" 新しいウィンドウで開く
" au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
" au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR><C-W>p
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR><C-W>p
" au FileType unite nmap <buffer> <ESC> <Plug>(unite_exit)

" 入力中の内容を削除する
au FileType unite inoremap <silent> <buffer> <C-k> <ESC>0C

" ショートカット
let g:unite_enable_start_insert=1
"let g:unite_enable_short_source_names = 1
"let g:unite_source_file_mru_filename_format = ''
" let g:unite_winheight=20

" バッファ一覧
" nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
nnoremap <silent> <C-g> :<C-u>Unite buffer<CR>
" ファイル一覧
" nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> ,uf :<C-u>Unite -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" ごちゃまぜ
nnoremap <C-f> :<C-u>Unite file file_rec/async -resume -no-quit<CR>
" 旧主力
" nnoremap <C-f> :<C-u>Unite buffer file_mru file_rec<CR>
" nnoremap <C-g> :<C-u>Unite grep<CR>

" let g:unite_source_rec_max_cache_files=2000
" call unite#custom_source(
"       \'file_rec', 
"       \'ignore_pattern',  
"       \'\('.
"       \ '\.\(jpg\|gif\|png\|swf\|bmp\|zip\|gz\)$'.
"       \ '\|\(ci\|converter\|coore_converter\|[Cc]ache[s]\{}\|error[s]\{}\|system\|third_party\|mpdf\|vendor\)/'.
"       \'\)')


"----------------------------------------------------------
" Neocomplcache
"----------------------------------------------------------
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
" let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
" -入力による候補番号の表示
let g:neocomplcache_enable_quick_match = 0
" 補完候補の一番先頭を選択状態にする(AutoComplPopと似た動作)
let g:neocomplcache_enable_auto_select = 1

" シンタックス補完を無効に
" let g:neocomplcache_plugin_disable = {
"   \ 'syntax_complete' : 1,
"   \ }

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
 \ 'default'    : '',
 \ 'php'        : $HOME . '/.vim/dict/php.dict',
 \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
 \ 'coffee'     : $HOME . '/.vim/dict/javascript.dict',
  \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" 関数を補完するための区切り文字パターン
if !exists('g:neocomplcache_delimiter_patterns')
  let g:neocomplcache_delimiter_patterns = {}
endif
let g:neocomplcache_delimiter_patterns['php'] = ['->', '::', '\']

" カーソルより後のキーワードパターンを認識。
" h|geとなっている状態(|はカーソル)で、hogeを補完したときに後ろのキーワードを認識してho|geと補完する機能。
" 修正するときにかなり便利。
if !exists('g:neocomplcache_next_keyword_patterns')
  let g:neocomplcache_next_keyword_patterns = {}
endif

" スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" vim標準のキーワード補完を置き換える
inoremap <expr><C-n> neocomplcache#manual_keyword_complete()

" 単語入力中だけ補完候補を出す
inoremap <expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
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

" バッファ共有設定
let g:neocomplcache_same_filetype_lists = {
\  'html' : 'html,javascript,php,ruby'
\, 'haml' : 'haml,javascript,ruby'
\, 'php'  : 'html,javascript,php'
\, 'js'   : 'html,php,ruby'
\ }

" Rsense
let g:neocomplcache#sources#rsense#home_directory = '/usr/local/Cellar/rsense/0.3'


"----------------------------------------------------------
" VimFiler
"----------------------------------------------------------
nnoremap <C-E> :VimFiler -buffer-name=explorer -split -winwidth=45 -toggle -no-quit<CR>
autocmd! FileType vimfiler call g:my_vimfiler_settings()
function! g:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)",  "\<Plug>(vimfiler_edit_file)")
  nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction


"----------------------------------------------------------
" Quickrun
" Color ref: http://goo.gl/sQDiY
"----------------------------------------------------------
" let g:quickrun_config = {}
" let g:quickrun_config._ = {'runner' : 'vimproc'}
" " let g:quickrun_config['ruby.rspec'] = {'command': "rspec"}
" let g:quickrun_config['ruby.rspec'] = { 'command': 'rspec',  'cmdopt': 'bundle exec',  'exec': '%o %c %s' }
" augroup RSpec
"   autocmd!
"   autocmd BufWinEnter, BufNewFile *_spec.rb set filetype=ruby.rspec
" augroup END

let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'exec': 'bundle exec %c %s', 
  \ 'outputter/buffer/filetype': 'rspec-result', 
  \}
let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'exec': '%c %s', 
  \ 'outputter/buffer/filetype': 'rspec-result', 
  \}
function! RSpecQuickrun()
  let b:quickrun_config = {'type' : 'rspec/bundle'}
endfunction
autocmd BufReadPost *_spec.rb call RSpecQuickrun()

"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['html'] }


"----------------------------------------------------------
" taglist
"----------------------------------------------------------
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags"
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Update = 1
let g:tlist_php_settings = 'php;c:class;d:constant;f:function'
nmap <Leader>tl :Tlist<CR>
au BufWrite *.php :TlistUpdate

"----------------------------------------------------------
" Unite-reek / Unite-rails-best-practice
" (http://qiita.com/items/acd2e2a642e67ef1dd72)
"----------------------------------------------------------
nnoremap <silent> <C-H><C-R> :<C-u>Unite -no-quit reek<CR>
nnoremap <silent> <C-H><C-R><C-R> :<C-u>Unite -no-quit rails_best_practices<CR>


"----------------------------------------------------------
" Octopress
"----------------------------------------------------------
let g:octopress_path = '~/code/lunchub.github.io'
map <Leader>on  :OctopressNew<CR>
map <Leader>ol  :OctopressList<CR>
map <Leader>og  :OctopressGrep<CR>
nmap ,og  :OctopressGenerate<CR>
nmap ,od  :OctopressDeploy<CR>


"----------------------------------------------------------
" simple-javascript-indenter
"----------------------------------------------------------
let g:SimpleJsIndenter_BriefMode = 1


"----------------------------------------------------------
" WinResizer 
"----------------------------------------------------------
"nnoremap <C-w> :WinResizerStartResize<CR>


"----------------------------------------------------------
" alignta
"----------------------------------------------------------
vnoremap <silent> => :Align @1 =><CR>
vnoremap <silent> = :Align @1 =<CR>
vnoremap <silent> == =


"----------------------------------------------------------
" Gist
"----------------------------------------------------------
let g:gist_clip_command = 'pbcopy'
" let g:gist_put_url_to_clipboard_after_post = 1

" ref http://goo.gl/7bJbm
func! s:paste_gist_tag()
  let mx = 'http[s]\?://gist.github.com/\([0-9]\+\)'
  " +または"レジスタの中身を検索する
  let regs = [@+,@"]
  for r in regs
    let mlist = matchlist(r, mx)
    if ( len(mlist) > 2 )
      "カーソル行に挿入
      exe "normal! O{% gist " . mlist[1] . " %}"
      return
    endif
  endif
endfunc
 
"コマンド
command! -nargs=0 PasteGist     call <SID>paste_gist_tag()


"----------------------------------------------------------
" vim-mlh / SKK
"----------------------------------------------------------
" let g:skk_control_j_key = ""
" let g:skk_large_jisyo = "$HOME/.vim/dict/SKK-JISYO.L"


"----------------------------------------------------------
" nathanaelkane/vim-indent-guides
"----------------------------------------------------------
let g:indent_guides_guide_size = 1


"----------------------------------------------------------
" NERDTree
"----------------------------------------------------------
" nnoremap <C-E> :NERDTreeToggle<CR>
