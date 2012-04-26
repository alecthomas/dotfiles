setlocal omnifunc=gocomplete#Complete
setlocal ts=2 noet sw=2 sts=2
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
" Automatically run Fmt before write
autocmd BufWritePre <buffer> silent execute 'Fmt'
