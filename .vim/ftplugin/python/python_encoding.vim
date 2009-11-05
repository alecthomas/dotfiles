if exists("b:did_ftplugin") | finish | endif

let s:pattern = '\(coding[:=]\s*\)\@<=\([0-9A-Za-z_-]\+\)'
let s:encoding = matchstr(getline(1), s:pattern)
if !strlen(s:encoding)
    let s:encoding = matchstr(getline(2), s:pattern)
endif

if strlen(s:encoding)
    let &encoding = s:encoding
endif
unlet s:pattern s:encoding
