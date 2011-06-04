setlocal textwidth=72
setlocal expandtab
setlocal nolist
setlocal wrap

let no_mail_maps=1

silent! %s/\(.\)<CR>\1/\1/g
silent! %s/_<CR>//g

hi def link mailQuoted1         Comment
hi def link mailQuoted2         String
hi def link mailQuoted3         Comment
hi def link mailQuoted4         String
hi def link mailQuoted5         Comment
hi def link mailQuoted6         String
hi def link mailSubject         String

