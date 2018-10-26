" This overrides the existing functionality of C-] - such as jumping to tags in a help file.
"nnoremap <C-]> :YcmCompleter GoTo<CR>
" Use the clipboard by default: set clipboard+=unnamedplus
" wundo and rundo for when switching buffers
" chrisbra/NrrwRgn
" romainl/vim-qf
" kana/vim-textobj-user
" Language Server Protocol
"Plug 'prabirshrestha/async.vim'
"Plug 'prabirshrestha/vim-lsp'
" use of vim-asterisk makes default '#' mapping pretty useless
" n and N are available
set encoding=utf-8
let s:vim_root = fnamemodify($MYVIMRC, ":p:h")

" Must specify to not generate system menu prior to switching on syntax or filetype recognition - plug#end() executes 'filetype plugin indent on' and 'syntax enable'.
set guioptions+=M


call plug#begin(s:vim_root . '/plugged')

" Plugin enhancements
Plug 'tpope/vim-repeat'

" Colorscheme
Plug 'chriskempson/base16-vim'

" Language support
Plug 'sheerun/vim-polyglot'

Plug 'valloric/youcompleteme'
let g:ycm_show_diagnostics_ui = 0

" Actions
" There is an unknown issue with the shorthand version 'tpope/vim-eunuch'.
Plug 'https://github.com/tpope/vim-eunuch.git'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'

" Movement enhancements
Plug 'wellle/targets.vim'
Plug 'justinmk/vim-sneak'
Plug 'matze/vim-move'

Plug 'haya14busa/vim-asterisk'
let g:asterisk#keeppos = 1

call plug#end()


colorscheme base16-default-dark


set autoindent
set autoread
set backspace=indent,eol,start
set complete-=i

" Find cursor more easily.
set cursorline

set display+=lastline

" Always insert spaces.
set expandtab

" Delete comment character when joining commented lines.
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

set guicursor=n-v-c:block,o:hor15,i-ci:ver10

" Do not use up screen space with menu, tool or scroll bars.
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

" Keep interface as close to terminal.
set guioptions+=!c

set history=1000
set laststatus=2
set nrformats-=octal

" Improve speed for line-based movements. Do not show number to reduce space taken up by line number column.
set relativenumber

set ruler

set scrolloff=1

" Always round indents to multiple of shiftwidth.
set shiftround

set smarttab

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

if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=100
endif

" Allow colorschemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux\|^Eterm'
  set t_Co=16
endif

set wildmenu

" Inform user when a file has been fully searched.
set nowrapscan


function! s:map(modes, lhs, rhs, ...)
  " Builds base map command appropriately depending on rhs.
  let l:map_cmd = (stridx(a:rhs, '<Plug>') == 0 ? '' : 'nore') . 'map' 
  let l:map_args = join(a:000)

  " For each character in modes.
  for l:mode in split(a:modes, '\zs')
    execute (l:mode . l:map_cmd) l:map_args a:lhs a:rhs
  endfor
endfunction
        
" s should always be sneak motion, even for operater-pending.
map s <Plug>Sneak_s
map S <Plug>Sneak_S

" Use stay behavior as default - more often desire is to stay with current word and this opens up '#' for a different mapping.
map * <Plug>(asterisk-z*)
map g* <Plug>(asterisk-gz*)

" <C-N> and <C-P> in normal are already covered by j and k and their usual functionality is compatible with n and N.
" Search repeat movements should always move in the same direction.
call s:map('nxo', '<C-N>', '"Nn"[v:searchforward]', '<expr>')
call s:map('nxo', '<C-P>', '"nN"[v:searchforward]', '<expr>')
" Better than default <C-N> and <C-P>.
cnoremap <C-N> <Down>
cnoremap <C-P> <Up>

" Use <C-L> to clear search highlighting.
nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>

" <Esc> always goes to normal mode.
tnoremap <Esc> <C-\><C-N>

" Allow sending <Esc> to terminal.
tnoremap <C-`> <Esc>

" Don't lose selection after shift.
xnoremap < <gv
xnoremap > >gv



nnoremap <C-/> :call StartSearch()<CR>

function! StartSearch()
  
endfunction
