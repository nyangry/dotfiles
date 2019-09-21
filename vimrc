set rtp+=/usr/local/opt/fzf

"====================================================================================
" Plugins
"====================================================================================
call plug#begin('~/.vim/plugged')

Plug 'junegunn/fzf.vim'
nnoremap    [fzf]   <Nop>
nmap      , [fzf]
nnoremap <silent> <C-f> :<C-u>CustomFZF<CR>
nnoremap <silent> [fzf]b :<C-u>FZFBuffers<CR>
nnoremap <silent> [fzf]m :<C-u>FZFMru<CR>
nnoremap <silent> [fzf]gg :<C-u>Agg<CR>
nnoremap <silent> [fzf]gk :<C-u>Agk<CR>
nnoremap <silent> [fzf]gc :<C-u>Agc<CR>

function! s:common_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vertical split',
    \ 'ctrl-n': 'tabe'
  \ }, a:lines[0], 'e')

  let list = map(a:lines[1:], '{"filename": v:val}')

  if a:lines[0] == 'ctrl-n'
    let first = list[0]
    execute cmd first.filename

    if len(list) > 1
      call setqflist(list)
      copen
      wincmd p
    endif
  else
    for file in list
      execute cmd file.filename
    endfor
  endif
endfunction

command! -nargs=* CustomFZF call fzf#run({
\   'source': 'git ls-files -oc --exclude-standard',
\   'sink*':    function('<sid>common_handler'),
\   'options': '-m -x --reverse --expect=enter,ctrl-s,ctrl-v,ctrl-n',
\   'down':    '50%'
\ })

command! FZFBuffers call fzf#run(fzf#wrap({
\   'source': map(range(1, bufnr('$')), 'bufname(v:val)'),
\   'sink*':    function('<sid>common_handler'),
\   'options': '-m -x --reverse --expect=enter,ctrl-s,ctrl-v,ctrl-n',
\   'down':    '50%'
\ }))

function! s:sort_buffers(...)
  let [b1, b2] = map(copy(a:000), 'get(g:fzf#vim#buffers, v:val, v:val)')
  " Using minus between a float and a number in a sort function causes an error
  return b1 < b2 ? 1 : -1
endfunction

function! s:buflisted()
  return filter(range(1, bufnr('$')), 'buflisted(v:val) && getbufvar(v:val, "&filetype") != "qf"')
endfunction

function! s:buflisted_sorted()
  return sort(s:buflisted(), 's:sort_buffers')
endfunction

function! s:all_files()
  return fzf#vim#_uniq(map(
    \ filter([expand('%')], 'len(v:val)')
    \   + filter(map(s:buflisted_sorted(), 'bufname(v:val)'), 'len(v:val)')
    \   + filter(copy(v:oldfiles), "filereadable(fnamemodify(v:val, ':p'))"),
    \ 'fnamemodify(v:val, ":~:.")'))
endfunction

command! FZFMru call fzf#run({
\   'source':  s:all_files(),
\   'sink*':    function('<sid>common_handler'),
\   'options': '-m -x --reverse --expect=enter,ctrl-s,ctrl-v,ctrl-n',
\   'down':    '50%'
\ })

function! s:ag_to_qf(line)
  let parts = split(a:line, ':')
  return {'filename': parts[0], 'lnum': parts[1], 'col': parts[2],
        \ 'text': join(parts[3:], ':')}
endfunction

function! s:ag_handler(lines)
  if len(a:lines) < 2 | return | endif

  let cmd = get({
    \ 'ctrl-s': 'split',
    \ 'ctrl-v': 'vertical split',
    \ 'ctrl-n': 'tabe'
  \ }, a:lines[0], 'e')

  let list = map(a:lines[1:], 's:ag_to_qf(v:val)')

  if a:lines[0] == 'ctrl-n'
    let first = list[0]
    execute cmd escape(first.filename, ' %#\')
    execute first.lnum
    execute 'normal!' first.col.'|zz'

    if len(list) > 1
      call setqflist(list)
      copen
      wincmd p
    endif
  else
    for file in list
      execute cmd file.filename
      execute file.lnum
      execute 'normal!' file.col.'|zz'
    endfor
  endif
endfunction

command! -nargs=* Agg call fzf#run({
\   'source':  printf('ag --column --color "%s"',
\                     escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\   'sink*':    function('<sid>ag_handler'),
\   'options': '--ansi --expect=ctrl-s,ctrl-v,ctrl-n '.
\              '-m -x --reverse '.
\              '--bind=ctrl-a:select-all,ctrl-d:deselect-all',
\   'down':    '50%'
\ })

command! -nargs=* Agk call fzf#run({
\   'source':  printf('ag --column --color "%s"',
\                     escape(empty(<q-args>) ? '^(?=.)' : <q-args>, '"\')),
\   'sink*':    function('<sid>ag_handler'),
\   'options': '--ansi --expect=ctrl-s,ctrl-v,ctrl-n '.
\              '--delimiter : --nth 4.. '.
\              '-m -x --reverse '.
\              '--bind=ctrl-a:select-all,ctrl-d:deselect-all',
\   'down':    '50%'
\ })

command! -nargs=* Agc call fzf#run({
\   'source':  printf('ag --column --color "%s"',
\                     escape(empty(<q-args>) ? expand('<cword>') : <q-args>, '"\')),
\   'sink*':    function('<sid>ag_handler'),
\   'options': '--ansi --expect=ctrl-s,ctrl-v,ctrl-n '.
\              '-m -x --reverse '.
\              '--bind=ctrl-a:select-all,ctrl-d:deselect-all',
\   'down':    '50%'
\ })

Plug 'scrooloose/nerdtree'
nnoremap <leader>f :NERDTreeFind<CR>
nnoremap <leader>fg :NERDTreeVCS<CR>
let g:NERDTreeWinSize = 70
let g:NERDTreeMinimalUI = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeCustomOpenArgs = {'file':{'where': 'v'}}
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'lucapette/vim-textobj-underscore'
Plug 'jwhitley/vim-matchit'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
let g:loaded_matchparen = 1
Plug 'itchyny/vim-parenmatch'
Plug 'itchyny/vim-cursorword'
Plug 'kana/vim-operator-user'
Plug 'kana/vim-operator-replace'
map R <Plug>(operator-replace)
Plug 'tyru/operator-camelize.vim'
map <leader>c <plug>(operator-camelize-toggle)
Plug 'osyo-manga/vim-anzu'
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
Plug 'tpope/vim-fugitive'
nmap gs :Gstatus<CR>
nmap gb :Gblame<CR>
nmap gd :Gdiff<CR>
autocmd FileType fugitiveblame call s:fugitiveblame_my_settings()
function! s:fugitiveblame_my_settings() abort
  nnoremap <silent> <C-p> :<C-u>!hub openpr <cword><CR>
endfunction
Plug 'tpope/vim-rhubarb'
Plug 'cohama/agit.vim'
let g:agit_preset_views = {
\ 'default': [
\   {'name': 'log'},
\   {'name': 'stat',
\    'layout': 'botright vnew'},
\   {'name': 'diff',
\    'layout': 'belowright {winheight(".") * 3 / 4}new'}
\ ],
\ 'file': [
\   {'name': 'filelog'},
\   {'name': 'stat',
\    'layout': 'botright vnew'},
\   {'name': 'diff',
\    'layout': 'belowright {winheight(".") * 3 / 4}new'}
\ ]}
nnoremap <silent> ,gaa :<C-u>Agit<CR>
nnoremap <silent> ,ga :<C-u>AgitFile<CR>
Plug 'rhysd/git-messenger.vim'
nmap <silent> <C-g> <Plug>(git-messenger)
autocmd FileType gitmessengerpopup call s:gitmessengerpopup_my_settings()
function! s:gitmessengerpopup_my_settings() abort
  nnoremap <silent> <C-p> :<C-u>!hub openpr <cword><CR>
endfunction
Plug 'w0rp/ale'
let g:prettier#config#print_width = 140
let g:prettier#config#arrow_parens = 'always'
let g:ale_completion_enabled = 1
let g:ale_linters = {
      \ 'html': ['htmlhint'],
      \ 'css': ['stylelint'],
      \ 'javascript': ['eslint']
      \ }
Plug 'jimsei/winresizer'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'LeafCage/yankround.vim'
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
Plug 'tomtom/tcomment_vim'
Plug 'bkad/CamelCaseMotion'
Plug 'kana/vim-fakeclip'
Plug 'h1mesuke/vim-alignta'
" Plug 'godlygeek/tabular'
Plug 'junegunn/vim-easy-align'
Plug 'Shougo/context_filetype.vim'
if !exists('g:context_filetype#same_filetypes')
  let g:context_filetype#same_filetypes = {}
endif
let g:context_filetype#same_filetypes.slim       = 'ruby'
let g:context_filetype#same_filetypes.yaml       = 'ruby'
let g:context_filetype#same_filetypes.scss       = 'css'
let g:context_filetype#same_filetypes.sass       = 'css'
let g:context_filetype#same_filetypes.es6        = 'javascript'
let g:context_filetype#same_filetypes.coffee     = 'javascript'
let g:context_filetype#same_filetypes.vue        = 'javascript'
let g:context_filetype#same_filetypes.typescript = 'javascript'
let g:context_filetype#filetypes = {
\ 'slim' : [
\   {
\    'start' : '^\s*-',
\    'end' : '$', 'filetype' : 'ruby',
\   },
\   {
\    'start' : '^\s*\w*=',
\    'end' : '$', 'filetype' : 'ruby',
\   },
\   {
\    'start' : '^\s*ruby:',
\    'end' : '^\S', 'filetype' : 'ruby',
\   },
\ ],
\ 'vue' : [
\   {
\    'start' : '^<script type=''ts''>',
\    'end' : '$', 'filetype' : 'typescript',
\   },
\ ]
\}
Plug 'shougo/neosnippet.vim'
imap <silent><c-k>     <plug>(neosnippet_jump_or_expand)
smap <silent><c-k>     <plug>(neosnippet_jump_or_expand)
xmap <silent><c-k>     <plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#enable_completed_snippet = 1
let g:neosnippet#expand_word_boundary = 1
let g:neosnippet#snippets_directory = '~/.vim/snippets'
Plug 'shougo/neosnippet-snippets'
let g:rubycomplete_rails                = 1
let g:rubycomplete_buffer_loading       = 1
let g:rubycomplete_classes_in_global    = 1
let g:rubycomplete_include_object       = 1
let g:rubycomplete_include_object_space = 1
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }
let g:rspec_command = "!bin/rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
Plug 'rhysd/vim-textobj-ruby', { 'for': 'ruby' }
Plug 'vim-scripts/ruby-matchit', { 'for': 'ruby' }
Plug 'slim-template/vim-slim', { 'for': 'slim' }
" HTML5 + inline SVG omnicomplete function, indent and syntax for Vim
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'cakebaker/scss-syntax.vim', { 'for': 'scss' }
" CSS3 syntax (and syntax defined in some foreign specifications) support for Vim’s built-in syntax/css.vim
Plug 'hail2u/vim-css3-syntax', { 'for': 'css' }
" This is a Vim plugin that provides Tern-based JavaScript editing support.
Plug 'ternjs/tern_for_vim', { 'for': 'javascript' }
" Yet Another JavaScript Syntax for Vim
Plug 'othree/yajs.vim' , { 'for': 'javascript' }
" Syntax for JavaScript libraries
Plug 'othree/javascript-libraries-syntax.vim', { 'for': 'javascript' }
let b:javascript_lib_use_jquery = 1
let b:javascript_lib_use_underscore = 1
" Vim indenter for standalone and embedded JavaScript and TypeScript.
Plug 'jason0x43/vim-js-indent', { 'for': 'javascript' }
Plug 'othree/es.next.syntax.vim', { 'for': 'javascript' }
" Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" CoffeeScript support for vim
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
Plug 'posva/vim-vue', { 'for': 'vue' }


call plug#end()


"====================================================================================
" Configuration
"====================================================================================
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

" html インデントの解除
" augroup stop_html_indent
"   autocmd!
"   autocmd FileType html :setlocal indentexpr=""
" augroup END

"====================================================================================
" Delete
"====================================================================================
nnoremap ,fd :call delete(expand('%'))<CR>

"====================================================================================
" View
"====================================================================================
" Ref: https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
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

set shortmess+=c

" これをしないと候補選択時に Scratch ウィンドウが開いてしまう
set completeopt=menuone,preview

autocmd FileType *
  \   if &l:omnifunc == ''
  \ |   setlocal omnifunc=syntaxcomplete#Complete
  \ | endif

" for performance
" set timeoutlen=500
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
nmap <leader>w :redraw!<CR>

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
" :inoremap ,n <C-R>=expand("%:t")<CR>

" To insert the absolute path of the directory the file is in use:
" :inoremap ,n <C-R>=expand("%:p:h")<CR>

" To insert the relative path of the directory the file is in use:
:inoremap <leader>fp <C-R>=expand("%:h")<CR>

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
" 編集中ファイルを別名で複製する
"====================================================================================
nnoremap <leader>dt :DuplicateTo <C-r>=expand('%:t')<CR>
function DuplicateTo(new_file_name, ...)
  let path = get(a:, 1, expand('%:h'))
  let new_file = path . '/' . a:new_file_name

  w `=new_file`
endfunction
command! -nargs=* DuplicateTo call DuplicateTo(<f-args>)

"====================================================================================
" Hack #17: 編集中ファイルのファイル名を変更する
"====================================================================================
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

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


"====================================================================================
" Profiling
"====================================================================================
" profile start profile.log
" profile func *
" profile file *
" profile pause
