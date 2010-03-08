set keywordprg=pydoc

" Use extended Python highlighter features
let python_highlight_all=1
let python_slow_sync=1

" Highlight 80th character as an error (PEP-8 expects max 79)
match ErrorMsg /\%<82v.\%>80v/
