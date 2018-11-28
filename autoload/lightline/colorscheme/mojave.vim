" =============================================================================
" Filename: autoload/lightline/colorscheme/mojave.vim
" Author: onose004
" License: MIT License
" Last Change: 2016/11/17 00:27:58.
" =============================================================================

" TODO: edit gui colors
let s:black = [ '#232526', 235 ]
let s:gray = [ '#808080', 237 ]
let s:white = [ '#f8f8f2', 255 ]
let s:cyan = [ '#66d9ef', 45 ]
let s:green = [ '#a6e22e', 77 ]
let s:orange = [ '#ef5939', 215 ]
let s:pink = [ '#f92672', 203 ]
let s:red = [ '#ff0000', 203 ]
let s:yellow = [ '#f2bc58', 215 ]
let s:blue = [ '#f2bc58', 33 ]

let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}

let s:p.normal.left = [ [ s:black, s:blue ], [ s:white, s:black ] ]
let s:p.normal.middle = [ [ s:white, s:black ] ]
let s:p.normal.right = [ [ s:blue, s:black ], [ s:black, s:blue ] ]
let s:p.normal.error = [ [ s:pink, s:black ] ]
let s:p.normal.warning = [ [ s:yellow, s:black ] ]
let s:p.insert.left = [ [ s:black, s:green ], [ s:white, s:black ] ]
let s:p.visual.left = [ [ s:black, s:yellow ], [ s:white, s:black ] ]
let s:p.replace.left = [ [ s:black, s:red ], [ s:red, s:black ] ]
let s:p.inactive.left =  [ [ s:white, s:black ], [ s:white, s:black ] ]
let s:p.inactive.middle = [ [ s:white, s:black ] ]
let s:p.inactive.right = [ [ s:white, s:gray ], [ s:white, s:black ] ]
let s:p.tabline.left = [ [ s:blue, s:black ] ]
let s:p.tabline.middle = [ [ s:blue, s:black] ]
let s:p.tabline.right = copy(s:p.normal.right)
let s:p.tabline.tabsel = [ [ s:white, s:gray ] ]

let g:lightline#colorscheme#mojave#palette = lightline#colorscheme#flatten(s:p)
