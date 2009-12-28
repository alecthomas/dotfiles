set keywordprg=pydoc

" Use extended Python highlighter features
let python_highlight_all=1
let python_slow_sync=1

" Highlight 81st character as an error (PEP-8)
match ErrorMsg /\%<82v.\%>81v/
