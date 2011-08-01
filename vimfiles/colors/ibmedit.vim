" Vim color file
" Maintainer:   Maarten Slaets
" Last Change:  2002 Aug 16

" Color settings similar to that used in IBM Edit

set background&
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="ibmedit"

hi Normal       guifg=#CCCCCC
hi NonText      guifg=#CCCCCC

hi Statement    guifg=White
hi Special      guifg=White
hi Constant     guifg=#99CCFF
hi Comment      guifg=#6666FF
hi Preproc      guifg=#99CCFF
hi Type         guifg=#CCCCCC
hi Identifier   guifg=#CCCCCC

hi StatusLine   gui=bold guifg=Black

hi StatusLineNC guifg=Black guibg=White

hi Visual       guifg=Black guibg=Gray

hi Search       guibg=Gray

hi VertSplit    guifg=Black guibg=White

hi Directory    guifg=Green

hi WarningMsg   gui=standout guifg=Red

hi Error        guifg=White guibg=Red

hi Cursor       guifg=Black guibg=Yellow

