" load borgmon file types
if exists("did_load_filetypes")
  finish
endif

augroup filetypedetect
  au! BufRead,BufNewFile *.go setfiletype go
  au! BufRead,BufNewFile *.as setfiletype javascript
  au! BufRead,BufNewFile *.json setfiletype json
  au! BufRead,BufNewFile *.re setfiletype reia
  au! BufRead,BufNewFile *.thrift setfiletype thrift
  au! BufRead,BufNewFile *.ccss setfiletype clevercss
  au! Filetype java setlocal omnifunc=javacomplete#Complete
augroup END
