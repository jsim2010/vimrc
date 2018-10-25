" Use the clipboard by default: set clipboard+=unnamedplus
" Add empty lines nnoremap [<Space> :<C-u>put! =repeat(nr2char(10), v:count1)<CR>'[
" nnoremap ]<Space> :<C-u>put =repeat(nr2char(10), v:count1)<CR>
" Don't lose selection after shift xnoremap < <gv
" xnoremap > >gv
" tpope/vim-abolish
" wundo and rundo for when switching buffers
" vim-scripts/a.vim
" junegunn/gv.vim
" haya14busa/is.vim
" chrisbra/NrrwRgn
" chrisbra/vim-diff-enhanced
" matze/vim-move
" terryma/vim-multiple-cursors
" kana/vim-textobj-user
set encoding=utf-8
let s:vim_root = fnamemodify($MYVIMRC, ":p:h")

" Must specify to not generate system menu prior to switching on syntax or filetype recognition - plug#end() executes 'filetype plugin indent on' and 'syntax enable'.
set guioptions+=M


call plug#begin(s:vim_root . '/plugged')

" Sensible settings
Plug 'tpope/vim-sensible'

" Plugin enhancements
Plug 'tpope/vim-repeat'

" Colorscheme
Plug 'chriskempson/base16-vim'

" Language support
Plug 'sheerun/vim-polyglot'

Plug 'valloric/youcompleteme'
let g:ycm_show_diagnostics_ui = 0

" Language Server Protocol
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'

" File operations
Plug 'https://github.com/tpope/vim-eunuch.git'

" Movement enhancements
Plug 'wellle/targets.vim'
Plug 'justinmk/vim-sneak'

call plug#end()


colorscheme base16-default-dark


" Find cursor more easily.
set cursorline

" Always insert spaces.
set expandtab

set guicursor=n-v-c:block,o:hor15,i-ci:ver10

" Do not use up screen space with menu, tool or scroll bars.
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Keep interface as close to terminal.
set guioptions+=!c

" Improve speed for line-based movements. Do not show number to reduce space taken up by line number column.
set relativenumber

" Always round indents to multiple of shiftwidth.
set shiftround

" When window is split, move to the created window.
set splitbelow
set splitright

" Mode can generally determined from cursor shape.
set noshowmode

if has('termguicolors')
  set termguicolors
endif

" Make tilde behave like operator.
set tildeop

" Inform user when a file has been fully searched.
set nowrapscan


" Make <C-n> and <C-p> in command mode act like they do in insert mode.
cnoremap <C-n> <Down>
cnoremap <C-p> <Up>

" Search repeat movements should always move in the same direction.
nnoremap <expr> n 'Nn'[v:searchforward]
nnoremap <expr> N 'nN'[v:searchforward]

" Search repeat movements should always move in the same direction.
onoremap <expr> n 'Nn'[v:searchforward]
onoremap <expr> N 'nN'[v:searchforward]

nnoremap <C-]> :YcmCompleter GoTo<CR>

omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

" <Esc> always goes to normal mode.
tnoremap <Esc> <C-\><C-n>
" Allow sending <Esc> to terminal.
tnoremap <C-`> <Esc>

" Search repeat movements should always move in the same direction.
xnoremap <expr> n 'Nn'[v:searchforward]
xnoremap <expr> N 'nN'[v:searchforward]
