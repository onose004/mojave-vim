" MojaveDark Theme: {{{
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

let g:colors_name = 'mojave-dark'

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

let g:mojave-dark_palette = {
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

if !exists('g:mojave-dark_bold')
  let g:mojave-dark_bold = 1
endif

if !exists('g:mojave-dark_italic')
  let g:mojave-dark_italic = 1
endif

if !exists('g:mojave-dark_underline')
  let g:mojave-dark_underline = 1
endif

if !exists('g:mojave-dark_undercurl') && g:mojave-dark_underline != 0
  let g:mojave-dark_undercurl = 1
endif

if !exists('g:mojave-dark_inverse')
  let g:mojave-dark_inverse = 1
endif

if !exists('g:mojave-dark_colorterm')
  let g:mojave-dark_colorterm = 1
endif

"}}}2
" Script Helpers: {{{2

let s:attrs = {
      \ 'bold': g:mojave-dark_bold == 1 ? 'bold' : 0,
      \ 'italic': g:mojave-dark_italic == 1 ? 'italic' : 0,
      \ 'underline': g:mojave-dark_underline == 1 ? 'underline' : 0,
      \ 'undercurl': g:mojave-dark_undercurl == 1 ? 'undercurl' : 0,
      \ 'inverse': g:mojave-dark_inverse == 1 ? 'inverse' : 0,
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
  if g:mojave-dark_colorterm || has('gui_running')
    return s:bg
  else
    return s:none
  endif
endfunction

"}}}2
" MojaveDark Highlight Groups: {{{2

call s:h('MojaveDarkBgLight', s:none, s:bglight)
call s:h('MojaveDarkBgLighter', s:none, s:bglighter)
call s:h('MojaveDarkBgDark', s:none, s:bgdark)
call s:h('MojaveDarkBgDarker', s:none, s:bgdarker)

call s:h('MojaveDarkFg', s:fg)
call s:h('MojaveDarkFgUnderline', s:fg, s:none, [s:attrs.underline])
call s:h('MojaveDarkFgBold', s:fg, s:none, [s:attrs.bold])

call s:h('MojaveDarkComment', s:comment)
call s:h('MojaveDarkCommentBold', s:comment, s:none, [s:attrs.bold])

call s:h('MojaveDarkSelection', s:none, s:selection)

call s:h('MojaveDarkSubtle', s:subtle)

call s:h('MojaveDarkCyan', s:cyan)
call s:h('MojaveDarkCyanItalic', s:cyan, s:none, [s:attrs.italic])

call s:h('MojaveDarkGreen', s:green)
call s:h('MojaveDarkGreenBold', s:green, s:none, [s:attrs.bold])
call s:h('MojaveDarkGreenItalic', s:green, s:none, [s:attrs.italic])
call s:h('MojaveDarkGreenItalicUnderline', s:green, s:none, [s:attrs.italic, s:attrs.underline])

call s:h('MojaveDarkOrange', s:orange)
call s:h('MojaveDarkOrangeBold', s:orange, s:none, [s:attrs.bold])
call s:h('MojaveDarkOrangeItalic', s:orange, s:none, [s:attrs.italic])
call s:h('MojaveDarkOrangeBoldItalic', s:orange, s:none, [s:attrs.bold, s:attrs.italic])
call s:h('MojaveDarkOrangeInverse', s:bg, s:orange)

call s:h('MojaveDarkPink', s:pink)
call s:h('MojaveDarkPinkItalic', s:pink, s:none, [s:attrs.italic])

call s:h('MojaveDarkPurple', s:purple)
call s:h('MojaveDarkPurpleBold', s:purple, s:none, [s:attrs.bold])
call s:h('MojaveDarkPurpleItalic', s:purple, s:none, [s:attrs.italic])

call s:h('MojaveDarkRed', s:red)
call s:h('MojaveDarkRedInverse', s:fg, s:red)

call s:h('MojaveDarkYellow', s:yellow)
call s:h('MojaveDarkYellowItalic', s:yellow, s:none, [s:attrs.italic])

call s:h('MojaveDarkError', s:red, s:none, [], s:red)

call s:h('MojaveDarkErrorLine', s:none, s:none, [s:attrs.undercurl], s:red)
call s:h('MojaveDarkWarnLine', s:none, s:none, [s:attrs.undercurl], s:orange)
call s:h('MojaveDarkInfoLine', s:none, s:none, [s:attrs.undercurl], s:red)

call s:h('MojaveDarkTodo', s:cyan, s:none, [s:attrs.bold, s:attrs.inverse])
call s:h('MojaveDarkSearch', s:green, s:none, [s:attrs.inverse])
call s:h('MojaveDarkBoundary', s:comment, s:bgdark)
call s:h('MojaveDarkLink', s:cyan, s:none, [s:attrs.underline])

call s:h('MojaveDarkDiffChange', s:none, s:none)
call s:h('MojaveDarkDiffText', s:bg, s:orange)
call s:h('MojaveDarkDiffDelete', s:red, s:bgdark)

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

hi! link ColorColumn  MojaveDarkBgDark
hi! link CursorColumn MojaveDarkBgDark
hi! link CursorLineNr MojaveDarkYellow
hi! link DiffAdd      MojaveDarkGreen
hi! link DiffAdded    DiffAdd
hi! link DiffChange   MojaveDarkDiffChange
hi! link DiffDelete   MojaveDarkDiffDelete
hi! link DiffRemoved  DiffDelete
hi! link DiffText     MojaveDarkDiffText
hi! link Directory    MojaveDarkPurpleBold
hi! link ErrorMsg     MojaveDarkRedInverse
hi! link FoldColumn   MojaveDarkSubtle
hi! link Folded       MojaveDarkBoundary
hi! link IncSearch    MojaveDarkOrangeInverse
hi! link LineNr       MojaveDarkComment
hi! link MoreMsg      MojaveDarkFgBold
hi! link NonText      MojaveDarkSubtle
hi! link Pmenu        MojaveDarkBgDark
hi! link PmenuSbar    MojaveDarkBgDark
hi! link PmenuSel     MojaveDarkSelection
hi! link PmenuThumb   MojaveDarkSelection
hi! link Question     MojaveDarkFgBold
hi! link Search       MojaveDarkSearch
hi! link SignColumn   MojaveDarkComment
hi! link TabLine      MojaveDarkBoundary
hi! link TabLineFill  MojaveDarkBgDarker
hi! link TabLineSel   Normal
hi! link Title        MojaveDarkGreenBold
hi! link VertSplit    MojaveDarkBoundary
hi! link Visual       MojaveDarkSelection
hi! link VisualNOS    Visual
hi! link WarningMsg   MojaveDarkOrangeInverse

" }}}
" Syntax: {{{

" Required as some plugins will overwrite
call s:h('MatchParen', s:green, s:none, [s:attrs.underline])
call s:h('Conceal', s:comment, s:bglight)

" Neovim uses SpecialKey for escape characters only. Vim uses it for that, plus whitespace.
if has('nvim')
  hi! link SpecialKey MojaveDarkRed
else
  hi! link SpecialKey MojaveDarkSubtle
endif

hi! link Comment MojaveDarkComment
hi! link Underlined MojaveDarkFgUnderline
hi! link Todo MojaveDarkTodo

hi! link Error MojaveDarkError
hi! link SpellBad MojaveDarkErrorLine
hi! link SpellLocal MojaveDarkWarnLine
hi! link SpellCap MojaveDarkInfoLine
hi! link SpellRare MojaveDarkInfoLine

hi! link Constant MojaveDarkPurple
hi! link String MojaveDarkYellow
hi! link Character MojaveDarkPink
hi! link Number Constant
hi! link Boolean Constant
hi! link Float Constant

hi! link Identifier MojaveDarkFg
hi! link Function MojaveDarkGreen

hi! link Statement MojaveDarkPink
hi! link Conditional MojaveDarkPink
hi! link Repeat MojaveDarkPink
hi! link Label MojaveDarkPink
hi! link Operator MojaveDarkPink
hi! link Keyword MojaveDarkPink
hi! link Exception MojaveDarkPink

hi! link PreProc MojaveDarkPink
hi! link Include MojaveDarkPink
hi! link Define MojaveDarkPink
hi! link Macro MojaveDarkPink
hi! link PreCondit MojaveDarkPink
hi! link StorageClass MojaveDarkPink
hi! link Structure MojaveDarkPink
hi! link Typedef MojaveDarkPink

hi! link Type MojaveDarkCyanItalic

hi! link Delimiter MojaveDarkFg

hi! link Special MojaveDarkPink
hi! link SpecialComment MojaveDarkCyanItalic
hi! link Tag MojaveDarkCyan
hi! link helpHyperTextJump MojaveDarkLink
hi! link helpCommand MojaveDarkPurple
hi! link helpExample MojaveDarkGreen
hi! link helpBacktick Special

"}}}

" vim: fdm=marker ts=2 sts=2 sw=2:
