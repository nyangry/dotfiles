" Ref:
"   - https://upload.wikimedia.org/wikipedia/commons/1/15/Xterm_256color_chart.svg
"   - http://vimdoc.sourceforge.net/htmldoc/syntax.html#%3ahighlight

set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "nyangry_dark"

" black
" 016 #000000

" hi TabLine        ctermfg=240   ctermbg=016  cterm=NONE
" hi TabLineFill    ctermfg=016  ctermbg=016  cterm=NONE
" hi TabLineSel     ctermfg=255   ctermbg=016  cterm=BOLD

hi Todo           ctermfg=red   ctermbg=NONE cterm=NONE
hi PreProc        ctermfg=white ctermbg=NONE cterm=BOLD
hi Identifier     ctermfg=white ctermbg=NONE cterm=NONE
hi Type           ctermfg=white ctermbg=NONE cterm=NONE
hi Keyword        ctermfg=white ctermbg=NONE cterm=BOLD
hi Statement      ctermfg=white ctermbg=NONE cterm=BOLD

hi Normal         ctermfg=255   ctermbg=NONE cterm=NONE
hi NonText        ctermfg=black ctermbg=NONE cterm=NONE
hi Comment        ctermfg=240   ctermbg=NONE cterm=NONE

hi LineNr         ctermfg=240   ctermbg=016  cterm=NONE
hi VertSplit      ctermfg=240   ctermbg=016  cterm=NONE

hi Search         ctermfg=black ctermbg=228  cterm=none
hi IncSearch      ctermfg=white ctermbg=018  cterm=none
hi ParenMatch     ctermfg=black ctermbg=228  cterm=none
hi matchParen     ctermfg=black ctermbg=228  cterm=none

" blue
" 017 darkblue
" 018 blue
" 075 lightblue
hi Function     ctermfg=white ctermbg=017  cterm=NONE
hi Pmenu        ctermfg=white ctermbg=017  cterm=BOLD
hi Number       ctermfg=white ctermbg=018  cterm=BOLD
hi Constant     ctermfg=white ctermbg=018  cterm=BOLD
hi PmenuSel     ctermfg=white ctermbg=075  cterm=BOLD
hi Visual       ctermfg=white ctermbg=075  cterm=NONE
hi String       ctermfg=075   ctermbg=NONE cterm=NONE
hi Delimiter    ctermfg=075   ctermbg=NONE cterm=NONE
hi ZenkakuSpace ctermfg=075   ctermbg=NONE cterm=underline
hi Special      ctermfg=075   ctermbg=NONE cterm=BOLD

" green
" 022 darkgreen
" 028 green
" 034 lightgreen
" hi Function     ctermfg=white ctermbg=022  cterm=NONE
" hi Pmenu        ctermfg=white ctermbg=022  cterm=BOLD
" hi Number       ctermfg=white ctermbg=028  cterm=BOLD
" hi Constant     ctermfg=white ctermbg=028  cterm=BOLD
" hi PmenuSel     ctermfg=white ctermbg=034  cterm=BOLD
" hi Visual       ctermfg=white ctermbg=034  cterm=NONE
" hi String       ctermfg=034   ctermbg=NONE cterm=NONE
" hi Delimiter    ctermfg=034   ctermbg=NONE cterm=NONE
" hi ZenkakuSpace ctermfg=034   ctermbg=NONE cterm=underline
" hi Special      ctermfg=034   ctermbg=NONE cterm=BOLD

" unite
hi link uniteMarkedLine Search

" ruby
hi link rubyConstant Number
hi link rubyClass Normal
hi link rubyInclude Normal
hi link rubyStatement Normal
hi link rubyModule Normal
hi link rubyDefine Normal
hi link rubyMacro Normal
hi link rubyAttribute Normal
hi link rubyAccess Normal
hi link rubySymbol Special
hi link rubyBoolean Keyword
hi link rubyPseudoVariable Keyword
hi link rubyControl Keyword
hi link rubyKeyword Keyword
hi link rubyConditional Keyword
hi link rubyConditionalModifier Keyword

" html
hi link htmlTag Keyword
hi link htmlTagName Keyword
hi link htmlSpecialTagName Keyword

" slim
hi link slimTag Keyword
hi link slimRuby Normal

" coffee
hi link coffeeGlobal Number
hi link coffeeObject Number
hi link coffeeObjAssign Function
hi link coffeeExtendedOp String

" javascript
hi link javascriptGlobal Number
hi link javascriptBOMWindowProp Number
