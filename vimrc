execute 'py3file' fnamemodify($MYVIMRC, ':p:h') . '/init.py'



command! Term terminal ++curwin
nnoremap <C-CR> :Term<CR>

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
