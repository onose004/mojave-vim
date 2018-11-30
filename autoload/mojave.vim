" Mojave Theme: {{{
"
" Code licensed under the MIT license
" http://zenorocha.mit-license.org
"
" Source code was forked from dracula/vim
"
" @author Ryosuke ONOSE <@onose004>

scriptencoding utf8
" }}}

" Configuration: {{{

if v:version > 580
  highlight clear
  if exists('syntax_on')
    syntax reset
  endif
endif

let g:colors_name = 'mojave'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" Palette: {{{2

" TODO: edit gui colors

let s:fg        = ['#ffffff', 255]

let s:bglighter = ['#424450', 237]
let s:bglight   = ['#343746', 236]
let s:bg        = ['#282A36', 235]
let s:bgdark    = ['#21222C', 234]
let s:bgdarker  = ['#191A21', 233]

let s:subtle    = ['#424450', 236]

let s:selection = ['#44475A', 238]
let s:comment   = ['#666666', 241]
let s:cyan      = ['#28d0fa',  45]
let s:green     = ['#78c064',  77]
let s:orange    = ['#FFB86C', 215]
let s:pink      = ['#FF79C6', 203]
let s:purple    = ['#aa69ab', 133]
let s:red       = ['#ed6d6e', 203]
let s:yellow    = ['#f2bc58', 215]

let s:none      = ['NONE', 'NONE']

let g:mojave_palette = {
      \ 'fg': s:fg,
      \ 'bg': s:bg,
      \ 'selection': s:selection,
      \ 'comment': s:comment,
      \ 'cyan': s:cyan,
      \ 'green': s:green,
      \ 'orange': s:orange,
      \ 'pink': s:pink,
      \ 'purple': s:purple,
      \ 'red': s:red,
      \ 'yellow': s:yellow,
      \
      \ 'bglighter': s:bglighter,
      \ 'bglight': s:bglight,
      \ 'bgdark': s:bgdark,
      \ 'bgdarker': s:bgdarker,
      \ 'subtle': s:subtle,
      \}

if has('nvim')
  let g:terminal_color_0  = '#21222C'
  let g:terminal_color_1  = '#FF5555'
  let g:terminal_color_2  = '#50FA7B'
  let g:terminal_color_3  = '#F1FA8C'
  let g:terminal_color_4  = '#BD93F9'
  let g:terminal_color_5  = '#FF79C6'
  let g:terminal_color_6  = '#8BE9FD'
  let g:terminal_color_7  = '#F8F8F2'
  let g:terminal_color_8  = '#6272A4'
  let g:terminal_color_9  = '#FF6E6E'
  let g:terminal_color_10 = '#69FF94'
  let g:terminal_color_11 = '#FFFFA5'
  let g:terminal_color_12 = '#D6ACFF'
  let g:terminal_color_13 = '#FF92DF'
  let g:terminal_color_14 = '#A4FFFF'
  let g:terminal_color_15 = '#FFFFFF'
endif

" }}}2
" User Configuration: {{{2

if !exists('g:mojave_bold')
  let g:mojave_bold = 1
endif

if !exists('g:mojave_italic')
  let g:mojave_italic = 1
endif

if !exists('g:mojave_underline')
  let g:mojave_underline = 1
endif

if !exists('g:mojave_undercurl') && g:mojave_underline != 0
  let g:mojave_undercurl = 1
endif

if !exists('g:mojave_inverse')
  let g:mojave_inverse = 1
endif

if !exists('g:mojave_colorterm')
  let g:mojave_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:mojave_bold == 1 ? 'bold' : 0,
      \ 'italic': g:mojave_italic == 1 ? 'italic' : 0,
      \ 'underline': g:mojave_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:mojave_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:mojave_inverse == 1 ? 'inverse' : 0,
      \}

function! s:h(scope, fg, ...) " bg, attr_list, special
  let l:fg = copy(a:fg)
  let l:bg = get(a:, 1, ['NONE', 'NONE'])

  let l:attr_list = filter(get(a:, 2, ['NONE']), 'type(v:val) == 1')
  let l:attrs = len(l:attr_list) > 0 ? join(l:attr_list, ',') : 'NONE'

  " Falls back to coloring foreground group on terminals because
  " nearly all do not support undercurl
  let l:special = get(a:, 3, ['NONE', 'NONE'])
  if l:special[0] !=# 'NONE' && l:fg[0] ==# 'NONE' && !has('gui_running')
    let l:fg[0] = l:special[0]
    let l:fg[1] = l:special[1]
  endif

  let l:hl_string = [
        \ 'highlight', a:scope,
        \ 'guifg=' . l:fg[0], 'ctermfg=' . l:fg[1],
        \ 'guibg=' . l:bg[0], 'ctermbg=' . l:bg[1],
        \ 'gui=' . l:attrs, 'cterm=' . l:attrs,
        \ 'guisp=' . l:special[0],
        \]

  execute join(l:hl_string, ' ')
endfunction

function! s:Background()
  if g:mojave_colorterm || has('gui_running')
    return s:bg
  else
    return s:none
  endif
endfunction

"}}}2
" Mojave Highlight Groups: {{{2

call s:h('MojaveBgLight', s:none, s:bglight)
call s:h('MojaveBgLighter', s:none, s:bglighter)
call s:h('MojaveBgDark', s:none, s:bgdark)
call s:h('MojaveBgDarker', s:none, s:bgdarker)

call s:h('MojaveFg', s:fg)
call s:h('MojaveFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('MojaveFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('MojaveComment', s:comment)
call s:h('MojaveCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('MojaveSelection', s:none, s:selection)

call s:h('MojaveSubtle', s:subtle)

call s:h('MojaveCyan', s:cyan)
call s:h('MojaveCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('MojaveGreen', s:green)
call s:h('MojaveGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('MojaveGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('MojaveGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('MojaveOrange', s:orange)
call s:h('MojaveOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('MojaveOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('MojaveOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('MojaveOrangeInverse', s:bg, s:orange)

call s:h('MojavePink', s:pink)
call s:h('MojavePinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('MojavePurple', s:purple)
call s:h('MojavePurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('MojavePurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('MojaveRed', s:red)
call s:h('MojaveRedInverse', s:fg, s:red)

call s:h('MojaveYellow', s:yellow)
call s:h('MojaveYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('MojaveError', s:red, s:none, [], s:red)

call s:h('MojaveErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('MojaveWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('MojaveInfoLine', s:none, s:none, [s:attrs.undercurl], s:red)

call s:h('MojaveTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('MojaveSearch', s:green, s:none, [s:attrs.inverse])
call s:h('MojaveBoundary', s:comment, s:bgdark)
call s:h('MojaveLink', s:cyan, s:none, [s:attrs.underline])

call s:h('MojaveDiffChange', s:none, s:none)
call s:h('MojaveDiffText', s:bg, s:orange)
call s:h('MojaveDiffDelete', s:red, s:bgdark)

" }}}2

" }}}
" User Interface: {{{

set background=dark

" Required as some plugins will overwrite
call s:h('Normal', s:fg, s:Background())
call s:h('StatusLine', s:none, s:bglighter, [s:attrs.bold])
call s:h('StatusLineNC', s:none, s:bglight)
call s:h('WildMenu', s:bg, s:purple, [s:attrs.bold])
call s:h('CursorLine', s:none, s:subtle)

hi! link ColorColumn  MojaveBgDark
hi! link CursorColumn MojaveBgDark
hi! link CursorLineNr MojaveYellow
hi! link DiffAdd      MojaveGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   MojaveDiffChange
hi! link DiffDelete   MojaveDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     MojaveDiffText
hi! link Directory    MojavePurpleBold
hi! link ErrorMsg     MojaveRedInverse
hi! link FoldColumn   MojaveSubtle
hi! link Folded       MojaveBoundary
hi! link IncSearch    MojaveOrangeInverse
hi! link LineNr       MojaveComment
hi! link MoreMsg      MojaveFgBold
hi! link NonText      MojaveSubtle
hi! link Pmenu        MojaveBgDark
hi! link PmenuSbar    MojaveBgDark
hi! link PmenuSel     MojaveSelection
hi! link PmenuThumb   MojaveSelection
hi! link Question     MojaveFgBold
hi! link Search       MojaveSearch
hi! link SignColumn   MojaveComment
hi! link TabLine      MojaveBoundary
hi! link TabLineFill  MojaveBgDarker
hi! link TabLineSel   Normal
hi! link Title        MojaveGreenBold
hi! link VertSplit    MojaveBoundary
hi! link Visual       MojaveSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   MojaveOrangeInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:comment, s:bglight)

" Neovim uses SpecialKey for escape characters only. Vim uses it for that, plus whitespace.
if has('nvim')
  hi! link SpecialKey MojaveRed
else
  hi! link SpecialKey MojaveSubtle
endif

hi! link Comment MojaveComment
hi! link Underlined MojaveFgUnderline
hi! link Todo MojaveTodo

hi! link Error MojaveError
hi! link SpellBad MojaveErrorLine
hi! link SpellLocal MojaveWarnLine
hi! link SpellCap MojaveInfoLine
hi! link SpellRare MojaveInfoLine

hi! link Constant MojavePurple
hi! link String MojaveYellow
hi! link Character MojavePink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier MojaveFg
hi! link Function MojaveGreen

hi! link Statement MojavePink
hi! link Conditional MojavePink
hi! link Repeat MojavePink
hi! link Label MojavePink
hi! link Operator MojavePink
hi! link Keyword MojavePink
hi! link Exception MojavePink

hi! link PreProc MojavePink
hi! link Include MojavePink
hi! link Define MojavePink
hi! link Macro MojavePink
hi! link PreCondit MojavePink
hi! link StorageClass MojavePink
hi! link Structure MojavePink
hi! link Typedef MojavePink

hi! link Type MojaveCyan

hi! link Delimiter MojaveFg

hi! link Special MojavePink
hi! link SpecialComment MojaveCyan
hi! link Tag MojaveCyan
hi! link helpHyperTextJump MojaveLink
hi! link helpCommand MojavePurple
hi! link helpExample MojaveGreen
hi! link helpBacktick Special

"}}}

" vim: fdm=marker ts=2 sts=2 sw=2:
