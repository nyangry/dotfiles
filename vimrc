set encoding=utf-8
scriptencoding utf-8

"====================================================================================
" Neobundle
"====================================================================================
if has('vim_starting')
  set nocompatible

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

if neobundle#load_cache()

  " Let NeoBundle manage NeoBundle
  NeoBundleFetch 'Shougo/neobundle.vim'

  "----------------------------------------------------------
  " Shougo san 
  "----------------------------------------------------------
  NeoBundle 'Shougo/vimproc.vim',  {
        \ 'build' : {
        \     'windows' : 'echo "Sorry,  cannot update vimproc binary file in Windows."',
        \     'cygwin'  : 'make -f make_cygwin.mak',
        \     'mac'     : 'make -f make_mac.mak',
        \     'unix'    : 'make -f make_unix.mak',
        \    },
        \ }
  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimfiler.vim'
  NeoBundle 'Shougo/neocomplete'
  NeoBundle 'Shougo/neosnippet'
  NeoBundle 'Shougo/neosnippet-snippets'

  "----------------------------------------------------------
  " textobj
  "----------------------------------------------------------
  NeoBundle 'kana/vim-textobj-user'
  NeoBundle 'kana/vim-textobj-line'
  NeoBundle 'kana/vim-textobj-entire'
  NeoBundle 'rhysd/vim-textobj-ruby'
  NeoBundle 'coderifous/textobj-word-column.vim'
  NeoBundle 'terryma/vim-expand-region'

  "----------------------------------------------------------
  " operator
  "----------------------------------------------------------
  NeoBundle 'kana/vim-operator-user.git'
  NeoBundle 'kana/vim-operator-replace.git'
  NeoBundle 'osyo-manga/vim-operator-blockwise'

  "----------------------------------------------------------
  " % による対応括弧へのカーソル移動機能を拡張
  " jwhitley/vim-matchit
  "----------------------------------------------------------
  NeoBundle 'jwhitley/vim-matchit'

  "----------------------------------------------------------
  " Tags
  "----------------------------------------------------------
  NeoBundle 'tsukkee/unite-tag'
  NeoBundle 'szw/vim-tags'
  NeoBundle 'vim-scripts/taglist.vim'

  "----------------------------------------------------------
  " ref
  "----------------------------------------------------------
  NeoBundle 'thinca/vim-ref'
  NeoBundle 'yuku-t/vim-ref-ri'

  "----------------------------------------------------------
  " Git
  "----------------------------------------------------------
  NeoBundle 'tpope/vim-fugitive'
  NeoBundle 'airblade/vim-gitgutter'
  NeoBundle 'cohama/agit.vim'
  NeoBundle 'idanarye/vim-merginal'
  NeoBundle 'kmnk/vim-unite-giti.git'
  NeoBundle 'rhysd/committia.vim'
  NeoBundle 'AndrewRadev/gapply.vim'

  "----------------------------------------------------------
  " Ruby
  "----------------------------------------------------------
  NeoBundle 'rhysd/unite-ruby-require.vim'
  NeoBundle 'vim-scripts/ruby-matchit'
  NeoBundle 'vim-ruby/vim-ruby'
  " NeoBundle 'marcus/rsense'
  " NeoBundle 'supermomonga/neocomplete-rsense.vim'

  "----------------------------------------------------------
  " Rais
  "----------------------------------------------------------
  NeoBundle 'tpope/vim-rails'

  "----------------------------------------------------------
  " RSpec
  "----------------------------------------------------------
  NeoBundle 'vim-scripts/AnsiEsc.vim'

  "----------------------------------------------------------
  " JavaScript
  "----------------------------------------------------------
  NeoBundle 'marijnh/tern'

  "----------------------------------------------------------
  " CSV
  "----------------------------------------------------------
  NeoBundle 'vim-scripts/csv.vim'

  "----------------------------------------------------------
  " Syntax
  "----------------------------------------------------------
  NeoBundle 'tpope/vim-haml'
  NeoBundle 'slim-template/vim-slim'
  NeoBundle 'othree/html5.vim'
  NeoBundle 'hail2u/vim-css3-syntax'
  NeoBundle 'cakebaker/scss-syntax.vim'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'scrooloose/syntastic'

  "----------------------------------------------------------
  " Others
  "----------------------------------------------------------
  " session
  NeoBundle 'tpope/vim-obsession'

  NeoBundle 'kannokanno/previm'
  NeoBundle 'tyru/open-browser.vim'
  NeoBundle 'itchyny/lightline.vim'
  NeoBundle 'jiangmiao/simple-javascript-indenter'
  NeoBundle 'osyo-manga/vim-over'
  NeoBundle 'jimsei/winresizer'
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'LeafCage/yankround.vim'
  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'tomtom/tcomment_vim'
  NeoBundle 'tpope/vim-surround'
  NeoBundle 'bkad/CamelCaseMotion'
  NeoBundle 'tpope/vim-endwise'
  NeoBundle 'terryma/vim-multiple-cursors'

  " 移動拡張 f / t
  NeoBundle 'rhysd/clever-f.vim'
  NeoBundle 'mattn/wiseman-f-vim'

  NeoBundle 'thinca/vim-visualstar'

  " コピペ自動判定処理
  NeoBundle 'ConradIrwin/vim-bracketed-paste'

  " fakeclip
  NeoBundle 'kana/vim-fakeclip'
  " Copy File Path/Name
  NeoBundle 'vim-scripts/copypath.vim'
  " 整形ツール
  NeoBundle 'h1mesuke/vim-alignta'

  NeoBundle 'airblade/vim-rooter'

  " NeoBundle 'itchyny/calendar.vim'

  NeoBundle 'daylerees/colour-schemes',  { 'rtp': 'vim-themes/'}

  NeoBundle 'AndrewRadev/switch.vim'

  NeoBundle 'osyo-manga/vim-anzu'

  NeoBundleSaveCache
endif

call neobundle#end()

filetype plugin indent on

"----------------------------------------------------------
" プラギン設定
"----------------------------------------------------------

"----------------------------------------------------------
" Unite
"----------------------------------------------------------
call unite#custom#profile('default', 'context', {
\   'direction': 'botright',
\ })
call unite#custom#profile('default', 'context.ignorecase', 1)
call unite#custom#profile('default', 'context.smartcase', 1)

" ウィンドウを分割して開く
augroup unite_keybinds
  autocmd!
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
  " ウィンドウを縦に分割して開く
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
  autocmd FileType unite inoremap <silent> <buffer> <expr> <C-i> unite#do_action('vsplit')
  " 新しいウィンドウで開く
  autocmd FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
  " autocmd FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('tabopen')
  " ESCキーを2回押すと終了する
  autocmd FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR><C-W>p
  autocmd FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR><C-W>p

  autocmd FileType unite nnoremap <silent><buffer><expr> r unite#do_action('rename')
  autocmd FileType unite nnoremap <silent><buffer><expr> m unite#do_action('move')
augroup END

if executable('ag')
  let g:unite_source_grep_command        = 'ag'
  let g:unite_source_grep_default_opts   = '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
                                            \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt  = ''
  " let g:unite_source_grep_max_candidates = 100
endif

" git ディレクトリかどうかで、処理を切り替える
" http://qiita.com/yuku_t/items/9263e6d9105ba972aea8
function! DispatchUniteFileRecAsyncOrGit()
  if isdirectory(getcwd()."/.git")
    Unite -start-insert file_rec/git:-c:-o:--exclude-standard
  else
    Unite -start-insert file_rec/async
  endif
endfunction

nnoremap <silent> ,gt :<C-u>Unite tab<CR>
nnoremap <silent> ,gr :<C-u>Unite grep:. -start-insert -buffer-name=search-buffer<CR>
nnoremap <silent> ,gs :<C-u>Unite giti/status<CR>
nnoremap <silent> ,gb :<C-u>Unite giti/branch_all<CR>

" nnoremap <silent> ,cg :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>

nnoremap <silent> <C-g> :<C-u>Unite buffer -start-insert<CR>

nnoremap ,us :<C-u>Unite file_rec -start-insert<CR>

nnoremap <C-f> :<C-u>call DispatchUniteFileRecAsyncOrGit()<CR>

call unite#custom#alias('file', 'delete', 'vimfiler__delete')
call unite#custom#alias('file', 'move', 'vimfiler__move')

" http://qiita.com/naoty_k/items/0f30a226621025897390
" .gitignoreで指定したファイルと.git/以下のファイルを候補から除外する
function! s:unite_gitignore_source()
  let sources = []
  if filereadable(expand('./.gitignore'))
    for file in readfile(expand('./.gitignore'))
      " コメント行と空行は追加しない
      if file !~ "^#\\|^\s\*$"
        call add(sources, file)
      endif
    endfor
  endif

  if isdirectory('./.git')
    call add(sources, '.git')
  endif

  call add(sources, '_repositories')
  call add(sources, 'vendor')
  call add(sources, 'assets/images')

  let pattern = escape(join(sources, '|'), './|~<>*')
  call unite#custom#source('file_rec/git,file_rec/async,file_rec ,grep', 'ignore_pattern', pattern)

  " call unite#custom#source('file_rec/git', 'ignore_pattern', pattern)
  " call unite#custom#source('file_rec/async', 'ignore_pattern', pattern)
  " call unite#custom#source('file_rec', 'ignore_pattern', pattern)
  " call unite#custom#source('grep', 'ignore_pattern', pattern)
endfunction
call s:unite_gitignore_source()


" \ (<SID>unite_gitignore_source()) .
" let ignore_pattern = '\(' .
"                       \ '_repositories' .
"                       \ '\)'

" \(\.DS_Store\|\.AppleDouble\|\.LSOverride\|Icon\|\._*\|\.Spotlight-V100\|\.Trashes\|\.AppleDB\|\.AppleDesktop\|Network Trash Folder\|Temporary Items\|\.apdisk\|*~\|\.directory\|[\._]*\.s[a-w][a-z]\|[\._]s[a-w][a-z]\|*\.un~\|Session\.vim\|\.netrwhist\|*~\|*\.gem\|*\.rbc\|\/\.config\|\/coverage\/\|\/InstalledFiles\|\/pkg\/\|\/spec\/reports\/\|\/test\/tmp\/\|\/test\/version_tmp\/\|\/tmp\/\|\.dat*\|\.repl_history\|build\/\|\/\.yardoc\/\|\/_yardoc\/\|\/doc\/\|\/rdoc\/\|\/\.bundle\/\|\/lib\/bundler\/man\/\|\.rvmrc\|*\.rbc\|capybara-*\.html\|\.rspec\|\/log\|\/tmp\|\/db\/*\.sqlite3\|\/public\/system\|\/coverage\/\|\/spec\/tmp\|**\.orig\|rerun\.txt\|pickle-email-*\.html\|config\/initializers\/secret_token\.rb\|config\/secrets\.yml\|\/\.bundle\|\/vendor\/bundle\|\.rvmrc\|\/vendor\/assets\/bower_components\|*\.bowerrc\|bower\.json\|spec\/dummy\/log\|spec\/dummy\/log\|spec\/dummy\/tmp\|spec\/dummy\/db\/*\.sqlite3\|spec\/dummy\/public\/system\|spec\/dummy\/coverage\/\|spec\/dummy\/spec\/tmp\|\.git\|_repositories\)

" call unite#custom_source(
"       \'file_rec, file_rec/async, file_rec/git, file/new',
"       \'ignore_pattern',
"       \'\('.
"       \ '\.\(svg\|jpg\|gif\|png\|swf\|bmp\|zip\|gz\|md\|map\|gitkeep\|DS_Store\|rdoc\|ru\)$'.
"       \ '\|\(LICENSE\|README\|CHANGELOG\|CONTRIBUT\)/'.
"       \ '\|\([Cc]ache[s]\{}\|error[s]\{}\|log[s]\{}\|doc[s]\{}\|font[s]\{}\|image[s]\{}\)/'.
"       \ '\|\(backup\|archived_migrations\)/'.
"       \ '\|\(vendor\|bundle\)/'.
"       \ '\|\(\.git\)/'.
"       \'\)')
"
" let ignore_pattern = '\('.
"                      '\.\(svg\|jpg\|gif\|png\|swf\|bmp\|zip\|gz\|md\|map\|gitkeep\|DS_Store\|rdoc\|ru\)$'.
"                      '\|\(LICENSE\|README\|CHANGELOG\|CONTRIBUT\)/'.
"                      '\|\([Cc]ache[s]\{}\|error[s]\{}\|log[s]\{}\|doc[s]\{}\|font[s]\{}\|image[s]\{}\)/'.
"                      '\|\(backup\|archived_migrations\)/'.
"                      '\|\(vendor\|bundle\)/'.
"                      '\|\(\.git\)/'.
"                      '\)'
" echo ignore_pattern

" custom ignore

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
" let g:neocomplete#sources._ = ['buffer', 'dictionary', 'syntax', 'include', 'omni']
let g:neocomplete#sources._ = ['buffer', 'dictionary', 'syntax', 'include']

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
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
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

let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'

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
  \ -direction=topleft -split -winwidth=50 -toggle -no-quit<CR>

nnoremap <silent> <Leader>fc :<C-u>VimFilerBufferDir
  \ -simple
  \ -direction=topleft -split -winwidth=50 -toggle -no-quit<CR>

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

"----------------------------------------------------------
" tsukkee/unite-tag
"----------------------------------------------------------
nnoremap <C-]> g<C-]>

"----------------------------------------------------------
" szw/vim-tags
" http://tkkbn.hatenablog.com/entry/2013/11/02/233701
"----------------------------------------------------------
let g:vim_tags_project_tags_command = "/usr/local/bin/ctags `pwd` 2>/dev/null"
let g:vim_tags_gems_tags_command    = "/usr/local/bin/ctags `bundle show --paths` 2>/dev/null"



" augroup VimTags
"   autocmd!
"   if exists(':TagsGenerate')
"     autocmd BufWritePost Gemfile TagsGenerate
"     autocmd BufEnter * TagsGenerate
"     autocmd BufWritePost * TagsGenerate
"   endif
" augroup END

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
		    \           [ 'readonly', 'filename', 'modified', 'anzu'] ],
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
" https://gist.github.com/alpaca-tc/6696152
"----------------------------------------------------------
function! s:separate_defenition_to_each_filetypes(ft_dictionary) "{{{
  let result = {}
 
  for [filetypes, value] in items(a:ft_dictionary)
    for ft in split(filetypes, ",")
      if !has_key(result, ft)
        let result[ft] = []
      endif
 
      call extend(result[ft], copy(value))
    endfor
  endfor
 
  return result
endfunction"}}}
 
nnoremap ! :Switch<CR>
let s:switch_definition = {
      \ '*': [
      \   ['is', 'are']
      \ ],
      \ 'ruby,eruby,haml' : [
      \   ['if', 'unless'],
      \   ['while', 'until'],
      \   ['.blank?', '.present?'],
      \   ['include', 'extend'],
      \   ['class', 'module'],
      \   ['.inject', '.delete_if'],
      \   ['.map', '.map!'],
      \   ['attr_accessor', 'attr_reader', 'attr_writer'],
      \ ],
      \ 'Gemfile,Berksfile' : [
      \   ['=', '<', '<=', '>', '>=', '~>'],
      \ ],
      \ 'ruby.application_template' : [
      \   ['yes?', 'no?'],
      \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
      \   ['controller', 'model', 'view', 'migration', 'scaffold'],
      \ ],
      \ 'erb,html,php' : [
      \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
      \ ],
      \ 'rails' : [
      \   [100, ':continue', ':information'],
      \   [101, ':switching_protocols'],
      \   [102, ':processing'],
      \   [200, ':ok', ':success'],
      \   [201, ':created'],
      \   [202, ':accepted'],
      \   [203, ':non_authoritative_information'],
      \   [204, ':no_content'],
      \   [205, ':reset_content'],
      \   [206, ':partial_content'],
      \   [207, ':multi_status'],
      \   [208, ':already_reported'],
      \   [226, ':im_used'],
      \   [300, ':multiple_choices'],
      \   [301, ':moved_permanently'],
      \   [302, ':found'],
      \   [303, ':see_other'],
      \   [304, ':not_modified'],
      \   [305, ':use_proxy'],
      \   [306, ':reserved'],
      \   [307, ':temporary_redirect'],
      \   [308, ':permanent_redirect'],
      \   [400, ':bad_request'],
      \   [401, ':unauthorized'],
      \   [402, ':payment_required'],
      \   [403, ':forbidden'],
      \   [404, ':not_found'],
      \   [405, ':method_not_allowed'],
      \   [406, ':not_acceptable'],
      \   [407, ':proxy_authentication_required'],
      \   [408, ':request_timeout'],
      \   [409, ':conflict'],
      \   [410, ':gone'],
      \   [411, ':length_required'],
      \   [412, ':precondition_failed'],
      \   [413, ':request_entity_too_large'],
      \   [414, ':request_uri_too_long'],
      \   [415, ':unsupported_media_type'],
      \   [416, ':requested_range_not_satisfiable'],
      \   [417, ':expectation_failed'],
      \   [422, ':unprocessable_entity'],
      \   [423, ':precondition_required'],
      \   [424, ':too_many_requests'],
      \   [426, ':request_header_fields_too_large'],
      \   [500, ':internal_server_error'],
      \   [501, ':not_implemented'],
      \   [502, ':bad_gateway'],
      \   [503, ':service_unavailable'],
      \   [504, ':gateway_timeout'],
      \   [505, ':http_version_not_supported'],
      \   [506, ':variant_also_negotiates'],
      \   [507, ':insufficient_storage'],
      \   [508, ':loop_detected'],
      \   [510, ':not_extended'],
      \   [511, ':network_authentication_required'],
      \ ],
      \ 'rspec': [
      \   ['describe', 'context', 'specific', 'example'],
      \   ['before', 'after'],
      \   ['be_true', 'be_false'],
      \   ['get', 'post', 'put', 'delete'],
      \   ['==', 'eql', 'equal'],
      \   { '\.should_not': '\.should' },
      \   ['\.to_not', '\.to'],
      \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
      \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
      \ ],
      \ 'markdown' : [
      \   ['[ ]', '[x]']
      \ ]
      \ }
 
let s:switch_definition = s:separate_defenition_to_each_filetypes(s:switch_definition)
function! s:define_switch_mappings() "{{{
  if exists('b:switch_custom_definitions')
    unlet b:switch_custom_definitions
  endif
 
  let dictionary = []
  for filetype in split(&ft, '\.')
    if has_key(s:switch_definition, filetype)
      let dictionary = extend(dictionary, s:switch_definition[filetype])
    endif
  endfor
 
  if exists('b:rails_root')
    let dictionary = extend(dictionary, s:switch_definition['rails'])
  endif
 
  if has_key(s:switch_definition, '*')
    let dictionary = extend(dictionary, s:switch_definition['*'])
  endif
endfunction"}}}
 
augroup SwitchSetting
  autocmd!
  autocmd Filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
augroup END


"----------------------------------------------------------
" airblade/vim-gitgutter
"----------------------------------------------------------
let g:gitgutter_max_signs = 3000


"----------------------------------------------------------
" agit.vim
"----------------------------------------------------------
nnoremap <silent> ,ga :<C-u>Agit<CR>


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
" set background=dark
" colorscheme flatland
" colorscheme hybrid
" colorscheme Tomorrow-Night-Bright
" colorscheme molokai

colorscheme ir_black

" hi Normal ctermbg=black

hi matchParen ctermbg=black ctermfg=green
hi Visual ctermbg=black ctermfg=lightcyan
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


"====================================================================================
" Complete
"====================================================================================
set ignorecase
set smartcase
set hlsearch
set incsearch " インクリメンタルサーチを行う
set listchars=eol:$,tab:>\ ,extends:< " listで表示される文字のフォーマットを指定する
set showmatch " 閉じ括弧が入力されたとき、対応する括弧を表示する
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

" 保存時に行末の空白を除去する
" augroup remove_space
"   autocmd!
"   autocmd BufWritePre * :%s/\s\+$//ge
" augroup END


"====================================================================================
" Mapping
"====================================================================================
nnoremap Y y$

"-------------------------------------------
" http:/qiita.com/tekkoc/items/98adcadfa4bdc8b5a6ca/
"-------------------------------------------
nnoremap s <Nop>
" nnoremap sj <C-w>j
" nnoremap sk <C-w>k
" nnoremap sl <C-w>l
" nnoremap sh <C-w>h
" nnoremap sJ <C-w>J
" nnoremap sK <C-w>K
" nnoremap sL <C-w>L
" nnoremap sH <C-w>H
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
