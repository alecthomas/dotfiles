" Reset defaults
set all&

if match(hostname(), "google.com") != -1
  set runtimepath^=~/.vim/work
else
  set runtimepath^=~/.vim/home
endif

" Enable snippeting
set runtimepath+=~/.vim/ultisnips

" Turn off annoying beeps
set vb
set noeb
set vb t_vb=

" Tell syntax highlighting we have a dark background
let &background = "dark"

" Force latin1 terminal encoding?
set fileencoding=utf-8
set encoding=utf-8
set termencoding=utf-8

" Allows ~<motion>
set tildeop

" Stupid backspace
set backspace=eol,indent,start

" 99% of the time, wrap is shit
set nowrap

" Fix crontab -e problem
set backupcopy=yes

" ctrl-n = next file
map <silent> <C-n> :bn<Enter>
" ctrl-p = previous file
map <silent> <C-p> :bN<Enter>

" Insert current date at cursor position
imap <silent> <C-d> <Esc>mm:r!date +\%Y-\%m-\%d<Enter>D`mp``dd``a
imap <silent> <C-t> <Esc>mm:r!date +\%H:\%M:\%S<Enter>D`mp``dd``a

" Map U to 'redo', which I like better than U being 'undo changes to this line'
map U <C-R>

" Alt-I/Alt-U indents and unindents respectively, the current block, excluding
" the brace lines themselves
map <M-i> mi>%`i<<`i%<<`i
map <M-u> mi>>`i%>>`i<%`i

" No 'Press ENTER...' message when using man
map K K<Enter>

" Abbreviate status messages
set shortmess=a

" Use insert key to toggle paste mode
set pastetoggle=<Ins>

" Filetypes that need real tabs
autocmd FileType make :set ts=4 noet nolist
" Defaults for indentation detection
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
autocmd BufReadPost * :DetectIndent

" Filetypes where we want 2-character spaces
autocmd FileType css,rst,javascript,htmldjango,xhtml,html,xml,mail :set ts=2 sw=2 sts=2

" Get rid of this exceptionally annoying 'feature'
noremap q: <C-l>
noremap q? <C-l>

syntax on

" Incremental search is good
set incsearch
set hlsearch
hi MatchParen cterm=NONE ctermfg=LightGreen ctermbg=NONE

" Disable highlighted search on redraw
map <silent> <C-l> :nohlsearch<Enter>:redraw!<Enter>

" ??
autocmd Syntax * syntax sync fromstart

" Show extra information about completion
"set completeopt=longest,menu

filetype plugin on
filetype indent on
set smartindent
set autoindent

" Tell extended Python highlighter
let python_highlight_space_errors=1
let python_highlight_all=1

" Always show cursor position
set ruler

" Store state across VIM sessions
set viminfo='50,<1000,s100,:100,f1,%

" Restore previous cursor position, expanding folds
augroup JumpCursorOnEdit
  au!
  autocmd BufReadPost *
    \ if expand("<afile>:p:h") !=? $TEMP |
    \   if line("'\"") > 1 && line("'\"") <= line("$") |
    \     let JumpCursorOnEdit_foo = line("'\"") |
    \     let b:doopenfold = 1 |
    \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
    \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
    \        let b:doopenfold = 2 |
    \     endif |
    \     exe JumpCursorOnEdit_foo |
    \   endif |
    \ endif
  " Need to postpone using "zv" until after reading the modelines.
  autocmd BufWinEnter *
    \ if exists("b:doopenfold") |
    \   exe "normal zv" |
    \   if(b:doopenfold > 1) |
    \       exe  "+".1 |
    \   endif |
    \   unlet b:doopenfold |
    \ endif
augroup END

" Fucking visual-select copying to clipboard! WTF!
set clipboard=

" C-d when file-completing
set wildmenu

" Omni-complete settings
inoremap <Nul> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>

let g:SuperTabDefaultCompletionType = "<C-X><C-N>"
"let g:SuperTabDefaultCompletionTypeDiscovery = "&omnifunc:<C-X><C-O>,&useKeywordCompletion:<C-X><C-I>"

let xml_use_xhtml = 1

" Make spell-correction/pyflakes colours less obtrusive
highlight SpellBad cterm=NONE ctermfg=darkred ctermbg=none

" De-uglify omni-complete menu
highlight Pmenu cterm=NONE ctermfg=Grey ctermbg=Blue
highlight PmenuSel cterm=NONE ctermfg=White ctermbg=Blue

" Show trailing whitepace and spaces before a tab:
highlight ExtraWhitespace cterm=NONE ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" PySmell options and supertab integration
set completeopt=menuone,longest,preview

" Change to working directory of current buffer. Very useful.
set autochdir
