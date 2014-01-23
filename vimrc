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
NeoBundle 'itchyny/lightline.vim'

NeoBundle 'https://github.com/Shougo/vimproc.git',  {
      \ 'build' : {
      \     'windows' : 'echo "Sorry,  cannot update vimproc binary file in Windows."', 
      \     'cygwin'  : 'make -f make_cygwin.mak', 
      \     'mac'     : 'make -f make_mac.mak', 
      \     'unix'    : 'make -f make_unix.mak', 
      \    }, 
      \ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/neosnippet'
" NeoBundle 'Shougo/vimshell'
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
" NeoBundle 'glidenote/octoeditor.vim'
" vim-rooter
NeoBundle 'airblade/vim-rooter'
" インデント対応表示
NeoBundle 'nathanaelkane/vim-indent-guides'
" replace
NeoBundle 'osyo-manga/vim-over'
" Calendar
NeoBundle 'itchyny/calendar.vim'
" Window size
NeoBundle 'jimsei/winresizer'

" colorscheme
" NeoBundle 'ujihisa/unite-colorscheme'

" source ssh
" NeoBundle 'Shougo/unite-ssh'


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
" NeoBundle 'Shougo/neocomplcache-rsense'
NeoBundle 'vim-scripts/ruby-matchit'
NeoBundle 'vim-ruby/vim-ruby'

"----------------------------------------------------------
" Rails
"----------------------------------------------------------
NeoBundle 'tpope/vim-rails'
" NeoBundle 'vim-scripts/dbext.vim'
" NeoBundle 'taichouchou2/alpaca_complete'
" NeoBundle 'taichouchou2/unite-reek'
" NeoBundle 'taichouchou2/unite-rails_best_practices'
NeoBundle 'romanvbabenko/rails.vim' " unite-rails-best-practiceが依存

"----------------------------------------------------------
" JavaScript
"----------------------------------------------------------
NeoBundle 'marijnh/tern'

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
NeoBundle 'tpope/vim-markdown'

"----------------------------------------------------------
" Complete
"----------------------------------------------------------
" NeoBundle 'teramako/jscomplete-vim'

" NeoBundle 'vimtaku/vim-mlh'
" NeoBundle 'tyru/skk.vim'





"----------------------------------------------------------
"----------------------------------------------------------

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
" nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" grep検索結果の再呼出
nnoremap <silent> ,r  :<C-u>UniteResume search-buffer<CR>

if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
  let g:unite_source_grep_recursive_opt = ''

  let g:unite_source_rec_async_command = 'ag'
endif

" メイン
nnoremap <C-f> :<C-u>Unite file_rec file/new<CR>

" call unite#custom#action('source/file_rec',  'delete',  'vimfiler__delete')

let g:unite_source_rec_max_cache_files=2000
call unite#custom_source(
      \'file_rec, file_rec/async', 
      \'ignore_pattern',  
      \'\('.
      \ '\.\(svg\|jpg\|gif\|png\|swf\|bmp\|zip\|gz\|md\|map\|gitkeep\|DS_Store\|rdoc\|ru\)$'.
      \ '\|\(LICENSE\|README\|CHANGELOG\|CONTRIBUT\)/'.
      \ '\|\([Cc]ache[s]\{}\|error[s]\{}\|log[s]\{}\|doc[s]\{}\)/'.
      \ '\|\(backup\|archived_migrations\)/'.
      \ '\|\(\.git\)/'.
      \'\)')


"----------------------------------------------------------
" Neocomplete
"----------------------------------------------------------
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

"let g:neocomplete#sources#buffer#cache_limit_size=500000
let g:neocomplete#sources#tags#cache_limit_size=500000000

 
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default'    : '',
  \ 'vimshell'   : $HOME . '/.vimshell_hist',
  \ 'scheme'     : $HOME . '/.gosh_completions',
  \ 'php'        : $HOME . '/.vim/dict/php.dict',
  \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
  \ 'coffee'     : $HOME . '/.vim/dict/javascript.dict',
\ }

if !exists('g:neocomplete#sources#include#paths')
  let g:neocomplete#sources#include#paths = {}
endif

if !exists('g:neocomplete#sources')
  let g:neocomplete#sources = {}
endif
let g:neocomplete#sources._ = ['buffer', 'syntax', 'include', 'file', 'dictionary', 'neosnippet', 'omni', 'tag']


" Define same filetypes
if !exists('g:neocomplete#same_filetypes')
  let g:neocomplete#same_filetypes = {}
endif
let g:neocomplete#same_filetypes.html   = 'javascript, php, ruby'
let g:neocomplete#same_filetypes.haml   = 'javascript, ruby'
let g:neocomplete#same_filetypes.php    = 'html, javascript'
let g:neocomplete#same_filetypes.scss   = 'html, haml, css'
let g:neocomplete#same_filetypes.js     = 'html, haml, php, ruby'
let g:neocomplete#same_filetypes.coffee = 'html, haml, javascript, ruby'
let g:neocomplete#same_filetypes.ruby   = 'haml, rails'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" 関数を補完するための区切り文字パターン
if !exists('g:neocomplete#delimiter_patterns')
  let g:neocomplete#delimiter_patterns = {}
endif
let g:neocomplete#delimiter_patterns.php = ['->',  '::',  '\']
let g:neocomplete#delimiter_patterns.vim = ['#']

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
" inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" スニペットを展開する。スニペットが関係しないところでは行末まで削除
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" Enable omni completion.
augroup enable_omni_completion
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup END

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'


"----------------------------------------------------------
" VimFiler
"----------------------------------------------------------
nnoremap <leader>f :VimFiler -buffer-name=explorer -split -columns="" -toggle -no-quit<CR>
function! g:my_vimfiler_settings()
  nmap     <buffer><expr><Cr> vimfiler#smart_cursor_map("\<Plug>(vimfiler_expand_tree)",  "\<Plug>(vimfiler_edit_file)")
  nnoremap <buffer>s          :call vimfiler#mappings#do_action('my_split')<Cr>
  nnoremap <buffer>v          :call vimfiler#mappings#do_action('my_vsplit')<Cr>
endfunction
augroup VimFiler
  autocmd! 
  autocmd FileType vimfiler call g:my_vimfiler_settings()
augroup END

autocmd FileType vimfiler 
  \ nnoremap <buffer><silent>/ 
  \ :<C-u>Unite file -default-action=vimfiler<CR>


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

augroup Quickrun
  autocmd!
  autocmd BufReadPost *_spec.rb call RSpecQuickrun()
augroup END



"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers=['jshint']
let g:syntastic_mode_map = { 'mode': 'active',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': ['html', 'css' ] }


"----------------------------------------------------------
" ctags
"----------------------------------------------------------
nnoremap <C-]> g<C-]> 


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


"----------------------------------------------------------
" Unite-reek / Unite-rails-best-practice
" (http://qiita.com/items/acd2e2a642e67ef1dd72)
"----------------------------------------------------------
nnoremap <silent> <C-H><C-R> :<C-u>Unite -no-quit reek<CR>
nnoremap <silent> <C-H><C-R><C-R> :<C-u>Unite -no-quit rails_best_practices<CR>


"----------------------------------------------------------
" Octopress
"----------------------------------------------------------
" let g:octopress_path = '~/code/lunchub.github.io'
" map <Leader>on  :OctopressNew<CR>
" map <Leader>ol  :OctopressList<CR>
" map <Leader>og  :OctopressGrep<CR>
" nmap ,og  :OctopressGenerate<CR>
" nmap ,od  :OctopressDeploy<CR>


"----------------------------------------------------------
" simple-javascript-indenter
"----------------------------------------------------------
let g:SimpleJsIndenter_BriefMode = 1


"----------------------------------------------------------
" vim-over 
"----------------------------------------------------------
nnoremap <silent> <Leader>m :OverCommandLine<CR>


"----------------------------------------------------------
" WinResizer 
"----------------------------------------------------------
nnoremap <C-q> :WinResizerStartResize<CR>


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


"----------------------------------------------------------
" alpaca_tags
"----------------------------------------------------------
NeoBundle 'alpaca-tc/alpaca_tags', {
      \ 'depends': ['Shougo/vimproc', 'Shougo/unite.vim'],
      \ 'autoload' : {
      \   'commands' : ['Tags', 'TagsUpdate', 'TagsSet', 'TagsBundle', 'TagsCleanCache'],
      \   'unite_sources' : ['tags']
      \ }}

let g:alpaca_tags_ctags_bin = '/usr/local/bin/ctags'

let g:alpaca_update_tags_config = {
      \ '_' : '-R --sort=yes --languages=+Ruby --languages=-css,scss,html',
      \ 'js' : '--languages=+js',
      \ 'ruby': '--languages=+Ruby',
      \ }

augroup AlpacaTags
  autocmd!
  " au FileWritePost,BufWritePost * call alpaca_tags#update_tags(&ft)
  autocmd BufWritePost * TagsUpdate
  autocmd BufWritePost Gemfile TagsBundle
  autocmd BufEnter * TagsSet
augroup END

" nnoremap <expr>tt  ':Unite tags -horizontal -buffer-name=tags -input='.expand("<cword>").'<CR>'
nnoremap <expr>tt  ':Unite tags -input='.expand("<cword>").'<CR>'


"====================================================================================
" Neobundle 
"====================================================================================
filetype plugin indent on     " required!









"====================================================================================
" 基本設定 
"====================================================================================
set nocompatible                 " vi互換なし
set encoding=utf-8
set fileencodings=utf-8
map ¥ <leader>
set scrolloff=5                  " スクロール時の余白確保
set textwidth=0                  " 一行に長い文章を書いていても自動折り返しを
set nobackup                     " バックアップ取らない
set noswapfile                   " スワップファイル作らない
set hidden                       " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start   " バックスペースでなんでも消せるように
set whichwrap=b,s,h,l,<,>,[,]    " カーソルを行頭、行末で止まらないようにする
set showcmd                      " コマンドをステータス行に表示
set showmode                     " 現在のモードを表示
set viminfo='50,<1000,s100,\"50  " viminfoファイルの設定
set modelines=0                  " モードラインは無効
set clipboard=unnamed,autoselect " OSのクリップボードを使用する

set mouse=a " ターミナルでマウスを使用できるようにする

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

" set guioptions+=a
set lazyredraw
set ttyfast
set ttymouse=xterm2
" set clipboard+=unnamed
" set clipboard+=autoselect
set laststatus=2 " 常にステータスラインを表示
set ruler " カーソルが何行目の何列目に置かれているかを表示する
set number " 行番号を表示する
" set noequalalways " ウインドウ幅の自動調整を行わない
syntax enable

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

" Delete
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
" View
"====================================================================================
set t_Co=256
" set background=dark
colorscheme ir_black


"====================================================================================
" Complete
"====================================================================================
set ignorecase
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
au BufRead,BufNewFile *.json set filetype=json
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
" Mapping
"====================================================================================
" 削除用レジスタを使用する
" nnoremap s "_s
" nnoremap x "_x
" nnoremap d "_d
" nnoremap dd "_dd
" nnoremap c "_c
" nnoremap C "_c
" xnoremap p "0P

" 表示行単位で行移動する
nnoremap <silent> j gj
nnoremap <silent> k gk
" " CTRL+sでrsyncを叩く
" nmap <Leader>r<CR> :! /Users/admin/code/sync_rep3.sh<CR>
" Escの2回押しでハイライト消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" q:、q/、q? は無効化
" nnoremap q: <NOP>
" nnoremap q/ <NOP>
" nnoremap q? <NOP>

" ビジュアルモードで選択したテキストで検索する
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>

" to 1.9 hash
" http://qiita.com/joker1007/items/965b63912512be94afa3
vnoremap <silent> <C-h> :s/:\([a-zA-Z0-9_]\+\)\s*=>/\1:/g<CR>

" 連続コピペ http://goo.gl/1Lp9Q
vnoremap <silent> <C-p> "0p<CR>

" redraw
nnoremap <C-w> :redraw!<CR>

"-------------------------------------------
" 自動補完
"-------------------------------------------
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

"-------------------------------------------
" 画面移動
"-------------------------------------------
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

"-------------------------------------------
" Hack #55: 正規表現のメタ文字の扱いを制御する
"-------------------------------------------
" nnoremap / /\v
" nnoremap ? ?\v


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
  if &ft == 'cpp' || &ft == 'java' || &ft == 'php' || &ft == 'javascript' || &ft == 'scss.css'
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
" Hack #161: Command-line windowを使いこなす
"====================================================================================
" nnoremap <sid>(command-line-enter) q:
" xnoremap <sid>(command-line-enter) q:
" nnoremap <sid>(command-line-norange) q:<C-u>
" 
" nmap :  <sid>(command-line-enter)
" xmap :  <sid>(command-line-enter)
" 
" augroup command-line-hack
"   autocmd CmdwinEnter * call s:init_cmdwin()
"   function! s:init_cmdwin()
"     nnoremap <buffer> q :<C-u>quit<CR>
"     nnoremap <buffer> <TAB> :<C-u>quit<CR>
"     inoremap <buffer><expr><CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
"     inoremap <buffer><expr><C-h> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
"     inoremap <buffer><expr><BS> pumvisible() ? "\<C-y>\<C-h>" : "\<C-h>"
" 
"     " Completion.
"     inoremap <buffer><expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" 
"     startinsert!
"   endfunction
" augroup END



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
augroup compilers
  autocmd!
  autocmd FileType javascript :compiler gjslint
  autocmd QuickfixCmdPost make copen
augroup END

