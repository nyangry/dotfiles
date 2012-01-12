" Nebuchadnezzar colorscheme
" $Id: nebuchadnezzar.vim,v 1.4 2010/01/31 23:43:04 ak Exp $
" Author:      azumakuniyuki
" Version:     1.0.5
" Last Change: Sun,  8 Jan 2012 02:35:07 +0900 (JST)

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = 'Nebuchadnezzar'

" See ':h syntax' or
" http://sites.google.com/site/vimdocja/syntax-html

" Normal(normal text)
hi Normal         gui=none guifg=#5b7e91 guibg=#16160e
"
" Comment(/** **/, //...)
hi Comment        gui=italic guifg=#455765 guibg=#16160e

" Constants
"	Boolean(true,false)
"	Character('c', '\n')
"	Number(123, 0xff)
"	Boolean(true, false)
"	Float(3.1415, 2.7e10)
"	String('string')
hi Constant       gui=none guifg=#e5e4e6 guibg=#16160e
hi Boolean        gui=bold guifg=#e5e4e6 guibg=#16160e
hi Character      gui=none guifg=#e5e4e6 guibg=#2b2b2b
hi Float          gui=none guifg=#e5e4e6 guibg=#16160e
hi Number         gui=none guifg=#e5e4e6 guibg=#16160e
hi String         gui=none guifg=#e5e4e6 guibg=#383c3c

" Identifier(variable names)
" Function(function names)
hi Identifier     gui=none guifg=#fbfaf5 guibg=#16160e
hi Function       gui=none guifg=#fbfaf5 guibg=#16160e

" Statements
"	Conditional(if, then, else, endif, switch,...)
"	Repeat(while, for, do, ...)
"	Label(case, default,...)
"	Operator(sizeof, +, -, ...)
"	Exception(try, catch, throw, ...)
hi Statement      gui=bold guifg=#5383c3 guibg=#16160e
hi Conditional    gui=bold guifg=#5383c3 guibg=#16160e
hi Exception      gui=bold guifg=#5383c3 guibg=#16160e
hi Keyword        gui=bold guifg=#5383c3 guibg=#16160e
hi Label          gui=bold guifg=#5383c3 guibg=#16160e
hi Operator       gui=bold guifg=#5383c3 guibg=#16160e
hi Repeat         gui=bold guifg=#5383c3 guibg=#16160e

" Preprocessors
"	Include(#include)
"	Define(#define)
"	Macro(equals to #define)
"	PreCondit(#if, #else, #endif, ...)
hi Define         gui=none guifg=#3e62ad guibg=#16160e
hi Include        gui=none guifg=#3e62ad guibg=#16160e
hi Macro          gui=none guifg=#3e62ad guibg=#16160e
hi PreCondit      gui=none guifg=#3e62ad guibg=#16160e
hi PreProc        gui=none guifg=#3e62ad guibg=#16160e

" Types
"	Type(int, char, long, ...)
"	StorageClass(static, register, volatile, ...)
"	Structure(struct, union, enum, ...)
"	Typedef(typedef declarations)
hi StorageClass   gui=bold guifg=#89c3eb guibg=#16160e
hi Structure      gui=bold guifg=#89c3eb guibg=#16160e
hi Type           gui=bold guifg=#89c3eb guibg=#16160e
hi Typedef        gui=bold guifg=#89c3eb guibg=#16160e

" Specials
"	Special(special symbols)
"	SpecialChar(special character constants)
"	Tag(Ctl-])
"	Delimiter,SpecialComment
"	Debug(debug statements)
hi Debug          gui=none guifg=#5b7e91 guibg=#16160e
hi Delimiter      gui=none guifg=#5b7e91 guibg=#16160e
hi Special        gui=none guifg=#5b7e91 guibg=#16160e
hi SpecialChar    gui=none guifg=#5b7e91 guibg=#16160e
hi SpecialComment gui=italic guifg=#426579 guibg=#16160e
hi Tag            gui=none guifg=#5b7e91 guibg=#16160e

" Errors and Warnings
hi Error          gui=bold guifg=#e5e4e6 guibg=#e2041b
hi ErrorMsg       gui=bold guifg=#e5e4e6 guibg=#e2041b
hi Todo           gui=none guifg=#2b2b2b guibg=#5b7e91
hi WarningMsg     gui=bold guifg=#2b2b2b guibg=#5b7e91

" Others
"	Underlined(hyperlinks(HTML), ...)
"	Ignore(white spaces, invisible characters)
hi Underlined     gui=underline guifg=#e5e4e6 guibg=#16160e
hi Ignore         gui=none guifg=#16160e guibg=#16160e

" Cursors,
"	Cursor(character in the cursor)
"	CursorIM(character in the cursor when IME is ON)
hi Cursor         gui=none guifg=#16160e guibg=#fffffc
hi CursorIM       gui=none guifg=#3e62ad guibg=#e5e4e6
hi lCursor        gui=none guifg=#3e62ad guibg=#e5e4e6
hi CursorLine     gui=underline guibg=#16160e

" Diff
hi DiffAdd        gui=bold guifg=#e5e4e6 guibg=#3e62ad
hi DiffChange     gui=none guifg=#e5e4e6 guibg=#3e62ad
hi DiffDelete     gui=none guifg=#e5e4e6 guibg=#3e62ad
hi DiffText       gui=bold guifg=#16160e guibg=#e5e4e6

" Areas
hi IncSearch      gui=none guifg=#2b2b2b guibg=#5b7e91
hi MatchParen     gui=none guifg=#e5e4e6 guibg=#5b7e91
hi Search         gui=none guifg=#2b2b2b guibg=#5b7e91
hi Visual         gui=none guifg=#e5e4e6 guibg=#5b7e91
hi VisualNOS      gui=underline guifg=#5b7e91 guibg=#16160e

" Window elements
"	ModeMsg(--INSERT--)
"	StatusLineNC(Non-Current Windows's status line)
"	Question('yes|no' question)
hi Directory      gui=none guifg=#e5e4e6 guibg=#16160e
hi FoldColumn     gui=bold guifg=#5b7e91 guibg=#3e62ad
hi Folded         gui=bold guifg=#5b7e91 guibg=#3e62ad
hi LineNr         gui=underline guifg=#426579 guibg=#16160e
hi ModeMsg        gui=bold guifg=#5b7e91 guibg=#16160e
hi MoreMsg        gui=bold guifg=#5b7e91 guibg=#16160e
hi Question       gui=bold guifg=#5b7e91 guibg=#16160e
hi StatusLine     gui=bold guifg=#e5e4e6 guibg=#5b7e91
hi StatusLineNC   gui=bold guifg=#2b2b2b guibg=#5b7e91
hi Title          gui=bold guifg=#e5e4e6 guibg=#2b2b2b
hi WildMenu       gui=none guifg=#3e62ad guibg=#e5e4e6
hi VertSplit      gui=none guifg=#5b7e91 guibg=#5b7e91

" Non texts
"	NonText(~,@,character specified by 'showbreak')
"	SpecialKey(keys defined by ':map', nonprintables)
hi NonText        gui=none guifg=#2b2b2b guibg=#16160e
hi SpecialKey     gui=none guifg=#2b2b2b guibg=#16160e


