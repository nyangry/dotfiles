set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif


let colors_name = "nyangry_dark"


hi Normal                                             ctermfg=NONE        ctermbg=NONE                cterm=NONE
hi NonText                                            ctermfg=black       ctermbg=NONE                cterm=NONE

hi Cursor                                             ctermfg=black       ctermbg=white               cterm=reverse
hi LineNr                                             ctermfg=darkgray    ctermbg=NONE                cterm=NONE

hi VertSplit                                          ctermfg=darkgray    ctermbg=darkgray            cterm=NONE
hi StatusLine                                         ctermfg=white       ctermbg=darkgray            cterm=NONE
hi StatusLineNC                                       ctermfg=blue        ctermbg=darkgray            cterm=NONE

hi Folded                                             ctermfg=NONE        ctermbg=NONE                cterm=NONE
hi Title                                              ctermfg=NONE        ctermbg=NONE                cterm=NONE
hi Visual                                             ctermfg=NONE        ctermbg=darkgray            cterm=NONE

hi SpecialKey                                         ctermfg=NONE        ctermbg=NONE                cterm=NONE

hi WildMenu                                           ctermfg=black       ctermbg=yellow              cterm=NONE
hi PmenuSbar                                          ctermfg=black       ctermbg=white               cterm=NONE

hi Error                                              ctermbg=darkred     ctermfg=white
hi ErrorMsg                                           ctermbg=darkred     ctermfg=white
hi WarningMsg                                         ctermfg=white       ctermbg=red                 cterm=NONE

" Message displayed in lower left, such as --INSERT--
hi ModeMsg                                            ctermfg=black       ctermbg=cyan                cterm=NONE

hi CursorLine                                         ctermfg=NONE        ctermbg=NONE                cterm=NONE
hi CursorColumn                                       ctermfg=NONE        ctermbg=NONE                cterm=NONE
hi MatchParen                                         ctermfg=white       ctermbg=darkgray            cterm=NONE
hi Pmenu                                              ctermfg=NONE        ctermbg=NONE                cterm=NONE
hi PmenuSel                                           ctermfg=NONE        ctermbg=NONE                cterm=NONE
hi Search                                             ctermfg=NONE        ctermbg=NONE                cterm=underline

hi Comment                                            ctermfg=darkgray    ctermbg=NONE                cterm=NONE
hi String                                             ctermfg=193       ctermbg=NONE                cterm=NONE
hi Number                                             ctermfg=magenta     ctermbg=NONE                cterm=NONE

hi Keyword                                            ctermfg=blue        ctermbg=NONE                cterm=NONE
hi PreProc                                            ctermfg=039        ctermbg=NONE                cterm=NONE
hi Conditional                                        ctermfg=blue        ctermbg=NONE                cterm=NONE      " if else end

hi Todo                                               ctermfg=red         ctermbg=NONE                cterm=NONE
hi Constant                                           ctermfg=cyan        ctermbg=NONE                cterm=NONE

hi Identifier                                         ctermfg=045        ctermbg=NONE                cterm=NONE
hi Function                                           ctermfg=brown       ctermbg=NONE                cterm=NONE
hi Type                                               ctermfg=yellow      ctermbg=NONE                cterm=NONE
hi Statement                                          ctermfg=039   ctermbg=NONE                cterm=NONE

hi Special                                            ctermfg=white       ctermbg=NONE                cterm=NONE
hi Delimiter                                          ctermfg=193        ctermbg=NONE                cterm=NONE
hi Operator                                           ctermfg=white       ctermbg=NONE                cterm=NONE

hi link Character Constant
hi link Boolean Constant
hi link Float Number
hi link Repeat Statement
hi link Label Statement
hi link Exception Statement
hi link Include PreProc
hi link Define PreProc
hi link Macro PreProc
hi link PreCondit PreProc
hi link StorageClass Type
hi link Structure Type
hi link Typedef Type
hi link Tag Special
hi link SpecialChar Special
hi link SpecialComment  Special
hi link Debug Special


hi matchParen                                         ctermbg=black       ctermfg=green
hi Visual                                             ctermbg=070         ctermfg=white
hi Search                                             ctermbg=blue        ctermfg=white     term=none cterm=none
hi Comment                                            ctermfg=245


hi Todo                                               ctermbg=darkred     ctermfg=white
hi WarningMsg                                         ctermbg=darkred     ctermfg=white
hi ModeMsg                                            ctermbg=darkred     ctermfg=white
hi NonText                                            ctermfg=white

hi Pmenu                                              ctermbg=black       ctermfg=lightcyan
hi PmenuSel                                           ctermbg=lightcyan   ctermfg=black
hi PMenuSbar                                          ctermbg=black

hi CursorLine                                         ctermbg=235         ctermfg=none

hi diffAdded                                          ctermfg=green
hi diffRemoved                                        ctermfg=darkred

hi uniteCandidateIcon                                 ctermfg=darkred
hi uniteCandidateInputKeyword                         ctermfg=darkred
hi uniteStatusLineNR                                  ctermfg=yellow
hi uniteMarkedLine                                    ctermfg=yellow

hi uniteSource__Grep                                  ctermfg=gray
" hi uniteSource__GrepFile                            ctermfg=cyan
hi uniteSource__GrepSeparator                         ctermfg=green
hi uniteSource__GrepPattern                           ctermfg=darkred
hi uniteSource__GrepLineNR                            ctermfg=blue
hi uniteSource__FileRecGit                            ctermfg=255
hi uniteSource__FileRecAsync                          ctermfg=195
hi uniteSource__FileMru                               ctermfg=45
" hi uniteSourceLine__uniteSource__Grep               ctermfg=magenta
" hi uniteSourceLine__uniteSource__FileRecGit         ctermfg=darkyellow

hi Function                                           ctermfg=yellow
hi vimFuncName                                        ctermbg=none        ctermfg=darkred

hi coffeeBoolean                                      ctermfg=red
hi coffeeObject                                       ctermfg=darkred
hi coffeeObjAssign                                    ctermfg=yellow
hi coffeeComment                                      ctermfg=245

hi hamlTag                                            ctermfg=yellow
hi hamlId                                             ctermfg=blue
hi hamlIdChar                                         ctermfg=blue
hi hamlClass                                          ctermfg=cyan
hi hamlClassChar                                      ctermfg=cyan
hi htmlTagName                                        ctermfg=yellow
" hi hamlRuby
" hi hamlRubyChar
" hi hamlRubyOutputChar


" Special for Ruby
hi rubyRegexp                                         ctermfg=darkgreen       ctermbg=NONE                cterm=NONE
hi rubyRegexpDelimiter                                ctermfg=darkgreen       ctermbg=NONE                cterm=NONE
" hi rubyEscape                                         ctermfg=cyan        ctermbg=NONE                cterm=NONE
" hi rubyInterpolationDelimiter                         ctermfg=blue        ctermbg=NONE                cterm=NONE
" hi rubyControl                                        ctermfg=blue        ctermbg=NONE                cterm=NONE      "and break, etc
" hi rubyGlobalVariable                                ctermfg=lightblue   ctermbg=NONE                cterm=NONE      "yield
" hi rubyStringDelimiter                                ctermfg=lightgreen  ctermbg=NONE                cterm=NONE
" hi rubyBoolean                                        ctermfg=red
" hi rubyInclude
" hi rubySharpBang
" hi rubyPredefinedVariable
" hi rubyClassVariable
" hi rubyBeginEnd
" hi rubyRepeatModifier
" hi rubyArrayDelimiter " [ , , ]
" hi rubyCurlyBlock " { , , }
" hi rubyInstanceVariable                               ctermfg=red
" hi rubyClass Keyword
" hi rubyModule Keyword
hi rubyConstant                                       ctermfg=231 ctermbg=NONE cterm=NONE
" hi link rubyKeyword Keyword
" hi link rubyOperator Operator
" hi link rubyIdentifier Identifier
" hi rubyFunction                                     ctermfg=darkred

" hi rubyMethodBlock                                  ctermfg=darkred
" hi rubyAccess                                         ctermfg=blue
" hi rubyRailsMethod                                  ctermfg=darkred
" hi rubyRailsFilterMethod                              ctermfg=red

" Agit.vim
hi agitStatAdded                                      ctermfg=green
hi agitStatRemoved                                    ctermfg=red
hi agitDiffAdd                                        ctermfg=green
hi agitDiffRemove                                     ctermfg=red

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
