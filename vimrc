" Set config to default values.
unlet! skip_defaults_vim
source $VIMRUNTIME/defaults.vim


let s:pkg_dir = fnamemodify($MYVIMRC, ':p:h') . '/pack/pkg/start'

function! AddPlugin(plugin)
  let l:plugin_name = split(a:plugin, "/")[-1]
  let l:plugin_dir = s:pkg_dir . "/" . l:plugin_name

  if !isdirectory(l:plugin_dir)
    execute 'terminal ++close git clone https://github.com/' . a:plugin . '.git ' . l:plugin_dir
  endif
endfunction

call mkdir(s:pkg_dir, "p")

call AddPlugin('tpope/vim-repeat')
call AddPlugin('chriskempson/base16-vim')
call AddPlugin('sheerun/vim-polyglot')
call AddPlugin('tpope/vim-eunich')
call AddPlugin('tpope/vim-unimpaired')
call AddPlugin('tpope/vim-abolish')
call AddPlugin('welle/targets.vim')

call AddPlugin('justinmk/vim-sneak')
" s and S should always be sneak motion
map s <Plug>Sneak_s
map S <Plug>Sneak_S

call AddPlugin('matze/vim-move')
call AddPlugin('kana/vim-textobj-user')


colorscheme base16-default-dark


set autoindent
set autoread
" Make it easier to find cursor.
set cursorline
" Widely agreed to always use spaces.
set expandtab
" Remove comment leader when joining lines.
set formatoptions+=j
set laststatus=2
" Reduce space taken by line number column.
set nonumber
" Improve speed for determining line-based movements.
set relativenumber
set shiftround
set smarttab
" When window is split, move to the created window.
set splitbelow
set splitright
" Mode can generally be determined from cursor shape.
set noshowmode

if has('termguicolors')
  set termguicolors
endif

" Make tilde behavior consistent.
set tildeop
set nowrapscan


" Improve <C-L> to update screen in all cases.
nnoremap <silent> <C-L> :diffupdate<CR>:redraw!<CR>
nnoremap <silent> <C-CR> :terminal ++curwin<CR>

" <Esc> should always return to Normal mode.
tnoremap <Esc> <C-\><C-N>
" Provide functionality to send <Esc> to terminal.
tnoremap <C-`> <Esc>

" Do not lose selection after shift.
vnoremap < <gv
vnoremap > >gv
