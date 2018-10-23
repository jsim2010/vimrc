let s:vim_home = fnamemodify($MYVIMRC, ":p:h")

" Must specify that system menu is not generated prior to switching on syntax or filetype recognition.
set guioptions+=M


call plug#begin(s:vim_home . '/plugged')

" Sensible settings
Plug 'tpope/vim-sensible'

" Plugin enhancements
Plug 'tpope/vim-repeat'

" Colorscheme
Plug 'chriskempson/base16-vim'

" File operations
Plug 'https://tpope.io/vim/eunuch.git'

" Movement enhancements
Plug 'wellle/targets.vim'
Plug 'justinmk/vim-sneak'

" Language Server Protocol
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'

call plug#end()


colorscheme base16-default-dark

" Always insert spaces.
set expandtab

set guicursor=n-v-c:block,o:hor15,i-ci:ver10

" Do not use up screen space with menu, tool or scroll bars.
set guioptions-=m
set guioptions-=T
set guioptions-=r


" Improve speed for line-based movements.
set relativenumber

if has('termguicolors')
  set termguicolors
endif

" Make tilde behave like operator.
set tildeop

" Inform user when a file has been fully searched.
set nowrapscan

" Follow E+H convention: set cinkeys-=0# cinoptions+=l1,g0,i0,c0,c1
" Use the clipboard by default: set clipboard+=unnamedplus
" set shiftround
" Mode is displayed by cursor shape and color: set noshowmode (need to make sure visual mode is detectable)


" Search repeat movements should always move in the same direction.
nnoremap <expr> n v:searchforward ? 'n' : 'N'
nnoremap <expr> N v:searchforward ? 'N' : 'n'

omap s <Plug>Sneak_s
omap S <Plug>Sneak_S

" <Esc> always goes to normal mode.
tnoremap <Esc> <C-\><C-n>
" Allow sending <Esc> to terminal.
tnoremap <C-`> <Esc>
