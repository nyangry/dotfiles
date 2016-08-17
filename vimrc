set encoding=utf-8
scriptencoding utf-8

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
call dein#begin(s:dein_dir)

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

"----------------------------------------------------------
" Shougo san
"----------------------------------------------------------
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/context_filetype.vim')
call dein#add('Shougo/neoinclude.vim')
call dein#add('Shougo/neco-vim')
call dein#add('Shougo/neco-syntax')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')

"----------------------------------------------------------
" textobj
"----------------------------------------------------------
call dein#add('kana/vim-textobj-user')
call dein#add('kana/vim-textobj-line')
call dein#add('lucapette/vim-textobj-underscore')
" call dein#add('kana/vim-textobj-entire')
" call dein#add('rhysd/vim-textobj-ruby')
" call dein#add('coderifous/textobj-word-column.vim')
" call dein#add('terryma/vim-expand-region')

"----------------------------------------------------------
" operator
"----------------------------------------------------------
call dein#add('kana/vim-operator-user.git')
call dein#add('kana/vim-operator-replace.git')
call dein#add('tyru/operator-camelize.vim')
" call dein#add('osyo-manga/vim-operator-blockwise')

"----------------------------------------------------------
" % による対応括弧へのカーソル移動機能を拡張
" jwhitley/vim-matchit
"----------------------------------------------------------
call dein#add('jwhitley/vim-matchit')

"----------------------------------------------------------
" Tags
"----------------------------------------------------------
call dein#add('tsukkee/unite-tag')
call dein#add('szw/vim-tags')
call dein#add('vim-scripts/taglist.vim')

"----------------------------------------------------------
" ref
"----------------------------------------------------------
" call dein#add('thinca/vim-ref')
" call dein#add('yuku-t/vim-ref-ri')

"----------------------------------------------------------
" Git
"----------------------------------------------------------
call dein#add('tpope/vim-fugitive')
call dein#add('cohama/agit.vim')
call dein#add('rhysd/committia.vim')
call dein#add('lambdalisue/vim-gita', {
      \ 'on_cmd': 'Gita',
      \})
" call dein#add('idanarye/vim-merginal')
call dein#add('kmnk/vim-unite-giti.git')
" call dein#add('AndrewRadev/gapply.vim')

"----------------------------------------------------------
" Ruby
"----------------------------------------------------------
call dein#add('rhysd/unite-ruby-require.vim')
call dein#add('vim-scripts/ruby-matchit')
call dein#add('vim-ruby/vim-ruby')
" call dein#add('marcus/rsense')
" call dein#add('supermomonga/neocomplete-rsense.vim')

"----------------------------------------------------------
" Rais
"----------------------------------------------------------
call dein#add('tpope/vim-rails')

"----------------------------------------------------------
" RSpec
"----------------------------------------------------------
call dein#add('vim-scripts/AnsiEsc.vim')

"----------------------------------------------------------
" JavaScript
"----------------------------------------------------------
call dein#add('marijnh/tern')

"----------------------------------------------------------
" CSV
"----------------------------------------------------------
call dein#add('vim-scripts/csv.vim')

"----------------------------------------------------------
" Syntax
"----------------------------------------------------------
call dein#add('tpope/vim-haml')
call dein#add('slim-template/vim-slim')
call dein#add('othree/html5.vim')
call dein#add('hail2u/vim-css3-syntax')
call dein#add('cakebaker/scss-syntax.vim')
call dein#add('kchmck/vim-coffee-script')
call dein#add('tpope/vim-markdown')
call dein#add('scrooloose/syntastic')

"----------------------------------------------------------
" Others
"----------------------------------------------------------
call dein#add('mhinz/vim-startify')

" session
call dein#add('tpope/vim-obsession')

" call dein#add('kannokanno/previm')
" call dein#add('tyru/open-browser.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('jiangmiao/simple-javascript-indenter')
call dein#add('osyo-manga/vim-over')
call dein#add('jimsei/winresizer')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('LeafCage/yankround.vim')
call dein#add('thinca/vim-quickrun')
call dein#add('tomtom/tcomment_vim')
call dein#add('tpope/vim-surround')
call dein#add('bkad/CamelCaseMotion')
call dein#add('tpope/vim-endwise')
" call dein#add('terryma/vim-multiple-cursors')

" 移動拡張 f / t
call dein#add('rhysd/clever-f.vim')
call dein#add('mattn/wiseman-f-vim')

" call dein#add('thinca/vim-visualstar')

" コピペ自動判定処理
call dein#add('ConradIrwin/vim-bracketed-paste')

" fakeclip
call dein#add('kana/vim-fakeclip')
" Copy File Path/Name
call dein#add('vim-scripts/copypath.vim')
" 整形ツール
call dein#add('h1mesuke/vim-alignta')
call dein#add('godlygeek/tabular')

" 置換強化
call dein#add('tpope/vim-abolish')

call dein#add('airblade/vim-rooter')

" call dein#add('itchyny/calendar.vim')

call dein#add('daylerees/colour-schemes',  { 'rtp': 'vim-themes/'})

call dein#add('AndrewRadev/switch.vim')
call dein#add('AndrewRadev/linediff.vim')

call dein#add('osyo-manga/vim-anzu')

call dein#add('zerowidth/vim-copy-as-rtf')

" [Vimの標準プラグインmatchparenが遅かったので8倍くらい速いプラグインを作りました - プログラムモグモグ](http://itchyny.hatenablog.com/entry/2016/03/30/210000)
let g:loaded_matchparen = 1
call dein#add('itchyny/vim-parenmatch')
call dein#add('itchyny/vim-cursorword')

" Required:
call dein#end()

" Required:
filetype plugin indent on

" vimprocだけは最初にインストールしてほしい
if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif

" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif

command! -nargs=0 DeinUpdate call dein#update()

"End dein Scripts-------------------------


"----------------------------------------------------------
" プラギン設定
"----------------------------------------------------------

"----------------------------------------------------------
" Unite
"----------------------------------------------------------
if executable('ag')
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --vimgrep --hidden --ignore ' .
  \ '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr''' .
  \ '''.hg'' --ignore ''vendor'' --ignore ''app/assets/images'''
  let g:unite_source_grep_recursive_opt = ''
  " let g:unite_source_grep_max_candidates = 100
endif

let g:unite_source_rec_async_command =
  \ ['ag', '--follow', '--nocolor', '--nogroup',
  \  '--hidden', '-g', '']

call unite#custom#profile('default', 'context', {
\   'direction': 'botright',
\   'start_insert': 1,
\   'context.ignorecase': 1,
\   'context.smartcase': 1
\ })

call unite#custom#source('file,file/new,buffer,file_rec,file_rec/async',
  \ 'ignore_pattern', join([
  \ '\(\.DS_Store\|\.keep\)',
  \ '\.git/',
  \ '\.bundle/',
  \ 'vendor/',
  \ 'app/assets/images/',
  \ 'node_modules/',
  \ ], '\|'))

call unite#custom#source('file,file/new,buffer,file_rec,file_rec/async',
  \ 'sorters', 'sorter_ftime')

call unite#custom#alias('file', 'delete', 'vimfiler__delete')
call unite#custom#alias('file', 'move', 'vimfiler__move')

" git ディレクトリかどうかで、処理を切り替える
" http://qiita.com/yuku_t/items/9263e6d9105ba972aea8
" file_rec/git は画像が大量にあるような場合にキツイ ls-files --exclude-standard した後に、画像や不要ファイルをフィルタする処理があれば使えそう
" function! DispatchUniteFileRecAsyncOrGit()
"   if isdirectory(getcwd()."/.git")
"     Unite file_rec/git:-c:-o:--exclude-standard
"   else
"     Unite file_rec/async
"   endif
" endfunction

" nnoremap <C-f> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>

nnoremap    [unite]   <Nop>
nmap      , [unite]
nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
nnoremap <silent> [unite]gg :<C-u>Unite grep:. -buffer-name=grep-buffer<CR>
" nnoremap <silent> [unite]gg :<C-u>Unite giti/grep:.<CR>
nnoremap <silent> [unite]gr :<C-u>Unite giti/remote<CR>
nnoremap <silent> [unite]gb :<C-u>Unite giti/branch<CR>
nnoremap <silent> [unite]gs :<C-u>Unite giti/status<CR>

nnoremap <silent> [unite]g :<C-u>Unite buffer<CR>
nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap <silent> <C-f> :<C-u>Unite file_rec/async<CR>

autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  " ウィンドウを縦に分割して開く
  nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
  inoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
  " 新しいウィンドウで開く
  nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
  " inoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
  " ESCキーを2回押すと終了する
  nnoremap <silent> <buffer> <ESC><ESC> :q<CR><C-W>p
  inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR><C-W>p

  nnoremap <silent><buffer><expr> r unite#do_action('rename')
  nnoremap <silent><buffer><expr> m unite#do_action('move')

  nnoremap <buffer><expr> S      unite#mappings#set_current_sorters(
            \ empty(unite#mappings#get_current_sorters()) ?
            \ ['sorter_ftime'] : [])
endfunction"}}}


"----------------------------------------------------------
" Neocomplete
"----------------------------------------------------------
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#disable_auto_complete = 0

" Use smartcase.
let g:neocomplete#enable_ignore_case = 0
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case = 1

" Use fuzzy completion.
let g:neocomplete#enable_fuzzy_completion = 1

" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
" Set auto completion length.
let g:neocomplete#auto_completion_start_length = 2
" Set manual completion length.
let g:neocomplete#manual_completion_start_length = 0
" Set minimum keyword length.
let g:neocomplete#min_keyword_length = 3

let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" For auto select.
let g:neocomplete#enable_complete_select = 1
try
  let completeopt_save = &completeopt
  set completeopt+=noinsert,noselect
catch
  let g:neocomplete#enable_complete_select = 0
finally
  let &completeopt = completeopt_save
endtry
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#enable_refresh_always = 0

if !exists('g:neocomplete#sources')
  let g:neocomplete#sources = {}
endif
let g:neocomplete#sources._ = ['buffer', 'member', 'dictionary', 'syntax', 'omni']

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default'    : '',
  \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
  \ 'coffee'     : $HOME . '/.vim/dict/javascript.dict',
  \ 'ruby'       : $HOME . '/.vim/dict/ruby.dict',
\ }

" Define same filetypes
if !exists('g:neocomplete#same_filetypes')
  let g:neocomplete#same_filetypes = {}
endif
let g:neocomplete#same_filetypes.html   = 'javascript, php, ruby'
let g:neocomplete#same_filetypes.haml   = 'javascript, ruby'
" let g:neocomplete#same_filetypes.php    = 'html, javascript'
let g:neocomplete#same_filetypes.scss   = 'css'
let g:neocomplete#same_filetypes.sass   = 'css'
" let g:neocomplete#same_filetypes.js     = 'html, haml'
let g:neocomplete#same_filetypes.coffee = 'javascript'
let g:neocomplete#same_filetypes.ruby   = 'haml, rails'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

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

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'

" Enable omni completion.
augroup enable_omni_completion
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  " autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  " autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
augroup END

let g:neocomplete#force_overwrite_completefunc = 1
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
if !exists('g:neocomplete#sources#omni#functions')
  let g:neocomplete#sources#omni#functions = {}
endif
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#enable_auto_close_preview = 1

" let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

" For smart TAB completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
       \ <SID>check_back_space() ? "\<TAB>" :
       \ neocomplete#start_manual_complete()
function! s:check_back_space() "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}


"----------------------------------------------------------
" VimFiler
"----------------------------------------------------------
" vim-rails のマッピング削除できねえ・・＼(^o^)／
" noremap gf <NOP>
" nnoremap gf <NOP>
" nmap gf <NOP>
" nmap <buffer>gf <NOP>
" nunmap <buffer>gf
" nnoremap <silent> <Plug>(vimfiler_find) :<C-u>call <SID>find()<CR>
" nmap gf <Plug>(vimfiler_find)
" au FileType vimfiler nnoremap <silent> <buffer> gf <Plug>(vimfiler_find)

let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_safe_mode_by_default = 0

" nnoremap <silent> <Leader>f :<C-u>VimFiler
nnoremap <silent> <Leader>f :<C-u>VimFilerExplorer -find
  \ -buffer-name=explorer -simple
  \ -direction=topleft -split -winwidth=50 -toggle<CR>


"----------------------------------------------------------
" Shougo/neomru.vim
"----------------------------------------------------------
let g:neomru#time_format = "(%Y/%m/%d %H:%M:%S) "


"----------------------------------------------------------
" mhinz/vim-startify
"----------------------------------------------------------
" When opening a file or bookmark, change to its directory.
let g:startify_change_to_dir = 1

" When opening a file or bookmark, seek and change to the root directory of the
" VCS (if there is one).
"
" At the moment only git, hg, bzr and svn are supported.
let g:startify_change_to_vcs_root = 1


"----------------------------------------------------------
" terryma/vim-expand-region
"----------------------------------------------------------
let g:expand_region_text_objects = {
      \ 'iw': 0,
      \ 'iW': 0,
      \ 'i"': 1,
      \ 'i''': 0,
      \ 'i}': 1,
      \ 'i]': 1,
      \ 'ib': 1,
      \ 'iB': 1,
      \ 'il': 0,
      \ 'ip': 0,
      \ 'ie': 0,
      \ }

vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

"----------------------------------------------------------
" tsukkee/unite-tag
"----------------------------------------------------------
nnoremap <C-]> g<C-]>

"----------------------------------------------------------
" szw/vim-tags
" http://tkkbn.hatenablog.com/entry/2013/11/02/233701
"----------------------------------------------------------
let g:vim_tags_auto_generate = 1
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags `pwd` 2>/dev/null"
let g:vim_tags_gems_tags_command    = "/usr/local/bin/ctags `bundle show --paths` 2>/dev/null"

"----------------------------------------------------------
" vim-scripts/taglist
"----------------------------------------------------------
nnoremap <leader>e :<C-u>TlistToggle<CR>
let Tlist_Use_Right_Window  = 1
let Tlist_Ctags_Cmd         = '/usr/local/bin/ctags'
let Tlist_Sort_Type         = 'order' " name or order
let Tlist_WinWidth          = 50
let Tlist_Display_Tag_Scope = 0
let Tlist_Show_One_File     = 1

let g:tlist_coffee_settings = 'coffee;c:class;f:function;v:variable'

"----------------------------------------------------------
" rsense
"----------------------------------------------------------
" let g:rsenseUseOmniFunc = 1

"----------------------------------------------------------
" Syntastic
"----------------------------------------------------------
let g:syntastic_auto_loc_list          = 1
let g:syntastic_javascript_checkers    = ['jshint']
let g:syntastic_coffee_checkers        = ['coffeelint']
let g:syntastic_mode_map               = { 'mode': 'active',
                                          \ 'active_filetypes': [],
                                          \ 'passive_filetypes': ['html', 'css' ] }
" let g:syntastic_ruby_checkers = ['rubocop']

"----------------------------------------------------------
" lightline
"----------------------------------------------------------
let g:lightline = {
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \ 'left': [ [ 'mode', 'paste' ],
        \           [ 'fugitive', 'readonly', 'filename', 'modified', 'anzu'] ],
        \ 'right': [ [ 'lineinfo' ],
        \            [ 'percent' ],
        \            [ 'tabnum' ],
        \            [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode',
        \   'anzu': 'anzu#search_status',
        \   'tabnum': 'TabNum',
        \ }
        \ }

" http://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
let s:base03 = [ '#151513', 233 ]
let s:base02 = [ '#30302c ', 236 ]
let s:base01 = [ '#4e4e43', 239 ]
let s:base00 = [ '#666656', 242  ]
let s:base0 = [ '#808070', 244 ]
let s:base1 = [ '#949484', 246 ]
let s:base2 = [ '#a8a897', 248 ]
let s:base3 = [ '#e8e8d3', 253 ]
let s:white = [ '#ffffff', 231 ]
let s:red = [ '#cf6a4c', 88 ]
let s:green = [ '#99ad6a', 70 ]
let s:blue = [ '#8197bf', 75 ]
let s:yellow = [ '#ffb964', 215 ]
let s:orange = [ '#fad07a', 222 ]
let s:magenta = [ '#f0a0c0', 217 ]
let s:cyan = [ '#8fbfdc', 88 ]

let g:lightline.colorscheme = 'custom_lightline'
let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
let s:p.normal.left = [ [ s:white, s:blue ], [ s:base3, s:base01 ] ]
let s:p.normal.right = [ [ s:base02, s:base1 ], [ s:base2, s:base01 ] ]
let s:p.inactive.right = [ [ s:base02, s:base00 ], [ s:base0, s:base02 ] ]
let s:p.inactive.left =  [ [ s:base0, s:base02 ], [ s:base00, s:base02 ] ]
let s:p.insert.left = [ [ s:white, s:red ], [ s:base3, s:base01 ] ]
let s:p.replace.left = [ [ s:base02, s:red ], [ s:base3, s:base01 ] ]
let s:p.visual.left = [ [ s:white, s:green ], [ s:base3, s:base01 ] ]
let s:p.normal.middle = [ [ s:base0, s:base02 ] ]
let s:p.inactive.middle = [ [ s:base00, s:base02 ] ]
let s:p.tabline.left = [ [ s:base3, s:base00 ] ]
let s:p.tabline.tabsel = [ [ s:base3, s:base02 ] ]
let s:p.tabline.middle = [ [ s:base01, s:base1 ] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.normal.error = [ [ s:red, s:base02 ] ]
let s:p.normal.warning = [ [ s:yellow, s:base01 ] ]
let g:lightline#colorscheme#custom_lightline#palette = lightline#colorscheme#flatten(s:p)
unlet s:p

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
        \ '' != expand('%') ? expand('%') : '[No Name]') .
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

function! TalNum(n)
  return lightline#tab#tabnum(a:n)
endfunction


"----------------------------------------------------------
" Yankround
"----------------------------------------------------------
nmap p <Plug>(yankround-p)
xmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap gp <Plug>(yankround-gp)
xmap gp <Plug>(yankround-gp)
nmap gP <Plug>(yankround-gP)
" nmap <C-p> <Plug>(yankround-prev)
" nmap <C-n> <Plug>(yankround-next)

"----------------------------------------------------------
" Quickrun
" Color ref: http://goo.gl/sQDiY
" RubyとvimでQuick JUnit風にテスト実行
" http://qiita.com/joker1007/items/69035c454de416849b8a
"----------------------------------------------------------
autocmd FileType quickrun AnsiEsc

let g:quickrun_config = {}
let g:quickrun_config._ = {'runner' : 'vimproc'}

" rspecを実行するための設定を定義する
" %cはcommandに設定した値に置換される
" %oはcmdoptに設定した値に置換される
" %sはソースファイル名に置換される
let g:quickrun_config['rspec/bundle'] = {
  \ 'type': 'rspec/bundle',
  \ 'command': 'rspec',
  \ 'outputter/buffer/filetype': 'rspec-result',
  \ 'exec': 'bundle exec %c %o --color %s'
  \}

let g:quickrun_config['rspec/normal'] = {
  \ 'type': 'rspec/normal',
  \ 'command': 'rspec',
  \ 'outputter/buffer/filetype': 'rspec-result',
  \ 'exec': '%c %o --color %s'
  \}

" :QuickRunで実行されるコマンドをrspec用の定義に設定する
" <Leader>lrをタイプした時に、:QuickRun -cmdopt "-l (カーソル行)"を実行するキーマップを定義する ← これがポイント
" function! RSpecQuickrun()
"   let b:quickrun_config = {'type' : 'rspec/bundle'}
"   nnoremap <expr><silent> <Leader>lr "<Esc>:QuickRun -cmdopt \"-l %{ line('.') } \"<CR>"
" endfunction

" ファイル名が_spec.rbで終わるファイルを読み込んだ時に上記の設定を自動で読み込む
" autocmd BufReadPost *_spec.rb call RSpecQuickrun()

function! RSpecQuickrun()
  let b:quickrun_config = {'type' : 'rspec/bundle'}
endfunction

augroup Quickrun
  autocmd!
  autocmd BufReadPost *_spec.rb call RSpecQuickrun()
augroup END


"----------------------------------------------------------
" simple-javascript-indenter
"----------------------------------------------------------
let g:SimpleJsIndenter_BriefMode = 1


"----------------------------------------------------------
" osyo-manga/vim-over
"----------------------------------------------------------
nnoremap <silent> <Leader>m :OverCommandLine<CR>


"----------------------------------------------------------
" nathanaelkane/vim-indent-guides
"----------------------------------------------------------
let g:indent_guides_guide_size = 1


"----------------------------------------------------------
" AndrewRadev/switch.vim
"----------------------------------------------------------
let g:switch_mapping = "-"


"----------------------------------------------------------
" cohama/agit.vim
"----------------------------------------------------------
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

nnoremap <silent> <leader>ga :<C-u>Agit<CR>
nnoremap <silent> <leader>g :<C-u>AgitFile<CR>

autocmd FileType agit call s:my_agit_setting()
function! s:my_agit_setting()
  nmap <buffer> rv <Plug>(agit-git-revert)
endfunction


"----------------------------------------------------------
" vim-ruby
"----------------------------------------------------------
let g:rubycomplete_rails                = 0
let g:rubycomplete_buffer_loading       = 1
let g:rubycomplete_classes_in_global    = 1
let g:rubycomplete_include_object       = 1
let g:rubycomplete_include_object_space = 1


"----------------------------------------------------------
" kana/vim-operator-replace.git
"----------------------------------------------------------
map R <Plug>(operator-replace)


"----------------------------------------------------------
" osyo-manga/vim-operator-blockwise
"----------------------------------------------------------
nmap YY <Plug>(operator-blockwise-yank-head)
nmap DD <Plug>(operator-blockwise-delete-head)
nmap CC <Plug>(operator-blockwise-change-head)


"----------------------------------------------------------
" osyo-manga/vim-anzu
"----------------------------------------------------------
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
" nmap n <Plug>(anzu-mode-n)
" nmap N <Plug>(anzu-mode-N)
nmap * <Plug>(anzu-star-with-echo)
nmap # <Plug>(anzu-sharp-with-echo)
augroup vim-anzu
" 一定時間キー入力がないとき、ウインドウを移動したとき、タブを移動したときに
" 検索ヒット数の表示を消去する
  autocmd!
  autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END


"----------------------------------------------------------
" tyru/operator-camelize.vim
"----------------------------------------------------------
map <leader>c <plug>(operator-camelize-toggle)


"====================================================================================
" 基本設定
"====================================================================================
map \ <leader>
set fileencodings=utf-8,sjis
set scrolloff=5                 " スクロール時の余白確保
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

set display=lastline
set pumheight=10

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
set ttymouse=xterm2
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
" ハイフン区切りのワードを選択しやすくする
" http://qiita.com/ponko2/items/0a14d0649f918f5e3ce7
setlocal iskeyword& iskeyword+=-

set cursorline " カーソル行をハイライト
" これをしないと候補選択時に Scratch ウィンドウが開いてしまう
set completeopt=menuone

" html インデントの解除
augroup stop_html_indent
  autocmd!
  autocmd FileType html :setlocal indentexpr=""
augroup END

"====================================================================================
" Rename
"====================================================================================
command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

"====================================================================================
" Delete
"====================================================================================
nnoremap <Leader>fd :call delete(expand('%'))<CR>


"====================================================================================
" 全角スペースを表示
"====================================================================================
function! ZenkakuSpace()
    hi ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        autocmd ColorScheme * call ZenkakuSpace()
        autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif


"====================================================================================
" 改行とタブ文字を表示
"====================================================================================
" set listchars=eol:¬,tab:▸\


"====================================================================================
" View
"====================================================================================
set t_Co=256

" Ref: https://upload.wikimedia.org/wikipedia/en/1/15/Xterm_256color_chart.svg
" set background=dark
" colorscheme flatland
" colorscheme hybrid
" colorscheme Tomorrow-Night-Bright
" colorscheme molokai

colorscheme ir_black

" hi Normal ctermbg=black

hi matchParen ctermbg=black ctermfg=green
hi Visual ctermbg=070 ctermfg=white
hi Search ctermbg=blue ctermfg=white term=none cterm=none
hi Comment ctermfg=245


hi Todo ctermbg=darkred ctermfg=white
hi Error ctermbg=darkred ctermfg=white
hi ErrorMsg ctermbg=darkred ctermfg=white
hi WarningMsg ctermbg=darkred ctermfg=white
hi ModeMsg ctermbg=darkred ctermfg=white
hi NonText ctermfg=white

hi Pmenu ctermbg=black ctermfg=lightcyan
hi PmenuSel ctermbg=lightcyan ctermfg=black
hi PMenuSbar ctermbg=black

hi CursorLine ctermbg=235 ctermfg=none

hi diffAdded ctermfg=green
hi diffRemoved ctermfg=darkred

hi uniteCandidateIcon ctermfg=darkred
hi uniteCandidateInputKeyword ctermfg=darkred
hi uniteStatusLineNR ctermfg=yellow
hi uniteMarkedLine ctermfg=yellow

hi uniteSource__Grep ctermfg=gray
" hi uniteSource__GrepFile ctermfg=cyan
hi uniteSource__GrepSeparator ctermfg=green
hi uniteSource__GrepPattern ctermfg=darkred
hi uniteSource__GrepLineNR ctermfg=blue
hi uniteSource__FileRecGit ctermfg=255
hi uniteSource__FileRecAsync ctermfg=195
hi uniteSource__FileMru ctermfg=45
" hi uniteSourceLine__uniteSource__Grep ctermfg=magenta
" hi uniteSourceLine__uniteSource__FileRecGit ctermfg=darkyellow

hi Function ctermfg=yellow
hi vimFuncName ctermbg=none ctermfg=darkred

" hi rubyFunction ctermfg=darkred
" hi rubyMethodBlock ctermfg=darkred
hi rubyAccess ctermfg=blue
hi rubyBoolean ctermfg=red
hi rubyConstant ctermfg=darkred
hi rubyRegexp ctermfg=darkgreen
hi rubyRegexpDelimiter ctermfg=darkgreen
" hi rubyRailsMethod ctermfg=darkred
hi rubyRailsFilterMethod ctermfg=red
hi rubyInstanceVariable ctermfg=red
" hi rubyCurlyBlock ctermfg=red

hi coffeeBoolean ctermfg=red
hi coffeeObject ctermfg=darkred
hi coffeeObjAssign ctermfg=yellow
hi coffeeComment ctermfg=245

hi hamlTag ctermfg=yellow
hi hamlId ctermfg=blue
hi hamlIdChar ctermfg=blue
hi hamlClass ctermfg=cyan
hi hamlClassChar ctermfg=cyan
hi htmlTagName ctermfg=yellow
" hi hamlRuby
" hi hamlRubyChar
" hi hamlRubyOutputChar

" Agit.vim
hi agitStatAdded ctermfg=green
hi agitStatRemoved ctermfg=red
hi agitDiffAdd ctermfg=green
hi agitDiffRemove ctermfg=red

" hi def link agitDiffAdd Identifier
" hi def link agitDiffAddMerge Identifier
" hi def link agitDiffRemove Special
" hi def link agitDiffRemoveMerge Special
" hi def link agitDiffHeader Type
" hi def link agitHeaderLabel Label
" hi def link agitDiffFileName Comment
" hi def link agitDiffIndex Comment
" hi def link agitDiffLine Comment
" hi def link agitDiffSubname PreProc


"====================================================================================
" Complete
"====================================================================================
set ignorecase
set smartcase
set hlsearch
set incsearch " インクリメンタルサーチを行う
set listchars=eol:$,tab:>\ ,extends:< " listで表示される文字のフォーマットを指定する
set showmatch
set matchtime=1
set showtabline=2
set expandtab
set tabstop<
set softtabstop=2
set shiftwidth=2
set nowrapscan " 検索をファイルの先頭へループしない
" コマンドライン補完するときに補完候補を表示する(tabで補完)
set wildmenu

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
autocmd BufWritePre * call <SID>remove_dust()


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
nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>

" 表示行単位で行移動する
nnoremap <silent> j gj
nnoremap <silent> k gk

" Escの2回押しでハイライト消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

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
:inoremap <leader>n <C-R>=expand("%:t:r")<CR>

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
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l


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
" Yankroundとかぶるからどうするか
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
" 最後に保存してから、どのくらい編集したのかの差分を表示
" http://nanasi.jp/articles/howto/diff/diff-original-file.html
" http://wada811.blogspot.com/2013/07/vimdiff-merge-and-difforig.html
"====================================================================================
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
    \ | wincmd p | diffthis
endif


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
