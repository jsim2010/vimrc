execute 'py3file' fnamemodify($MYVIMRC, ':p:h') . '/init.py'

call plug#begin(fnamemodify($MYVIMRC, ":p:h") . '/plugged')

" Plugin enhancements
Plug 'jsim2010/vpi'
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
" kana/vim-textobj-user

call plug#end()



nnoremap <C-q> :call StartSearch()<CR>

function! StartSearch()
  let g:search_current_bufnr = bufnr('')
  let g:search_file = expand('%:p')
  call vpi#loclist#clear(0)
  leftabove lopen
  redraw
  let l:is_running = v:true
  let l:current_expression = ''
  let g:search_job = job_start('help')
  
  while l:is_running
    let l:char = getchar()

    if l:char == 27
      " <ESC>
      let l:is_running = v:false
    elseif l:char == 13
      " <CR>
      let l:is_running = v:false
      normal! 
    elseif l:char == 14
      " <C-N>
      normal! j
      redraw
    elseif l:char == 16
      " <C-P>
      normal! k
      redraw
    elseif l:char ==# "\<BS>"
      let l:current_expression = l:current_expression[0:-2]
      call Search(l:current_expression)
    else
      let l:current_expression .= nr2char(l:char)
      call Search(l:current_expression)
    endif
  endwhile

  lclose
endfunction

function! Search(expression)
  call vpi#loclist#clear(g:search_current_bufnr)
  call vpi#loclist#config(g:search_current_bufnr, {'title': a:expression})

  if job_status(g:search_job) ==# 'dead'
    call job_stop(g:search_job)
  endif

  let g:search_job = job_start('find /N "' . a:expression . '" ' . g:search_file, {'out_cb': 'MyHandler', 'exit_cb': 'ExitHandler'})
endfunction

function! MyHandler(channel, msg)
  if a:msg[0] ==# '['
    call vpi#loclist#add(g:search_current_bufnr, [{'bufnr': g:search_current_bufnr, 'lnum': str2nr(substitute(a:msg, '[', '', '')), 'text': a:msg})
  endif
endfunction

function! ExitHandler(job, status)
  redraw
endfunction
