" Reset defaults
set all&

if filereadable(expand('~/.vimrc.local'))
  so ~/.vimrc.local
endif

let mapleader=","

let g:pyflakes_use_quickfix = 0

" Enable snippeting
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
set runtimepath+=~/.vim/ultisnips

" Expand %% to enclosing directory of currently edited file.
cabbr <expr> %% expand('%:p:h')

" Use 'Q' to reformat
vmap Q gq
nmap Q gqap

" Turn off annoying beeps
set vb
set noeb
set vb t_vb=

" Tell syntax highlighting we have a dark background
let &background = "dark"

set tags=tags;/

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
map <silent> <C-n> :bn<CR>
" ctrl-p = previous file
map <silent> <C-p> :bN<CR>

" Insert current date at cursor position
imap <silent> <C-d> <Esc>mm:r!date +\%Y-\%m-\%d<CR>D`mp``dd``a
imap <silent> <C-t> <Esc>mm:r!date +\%H:\%M:\%S<CR>D`mp``dd``a

" Map U to 'redo', which I like better than U being 'undo changes to this line'
map U <C-R>

" Indentation defaults
set ts=2 sts=2 sw=2 et

" No 'Press ENTER...' message when using man
map K K<CR>

" Abbreviate status messages
set shortmess=aTI

" Use insert key to toggle paste mode
if has('gui_macvim')
  set transparency=20
  set pastetoggle=<Help>
  set guifont=Menlo:h12
  set antialias
  " PeepOpen support
  map <D-e> <Plug>PeepOpen
  " Open tags in new tabs
  nmap <C-]> <C-w><C-]><C-w>T
  " Disable scrollbar
  set guioptions-=r 
  " Cmd+/ toggle comment
  map <D-/> ,c<Space>
  let g:CommandTAcceptSelectionMap = '<C-t>'
  let g:CommandTAcceptSelectionTabMap = '<CR>'
else
  set pastetoggle=<Ins>
endif

" XXX This should be something else on non-Mac platforms
let pyref_browser='/usr/bin/open'
let pyref_mapping='K'


" Don't autoclose
au FileType html,xhtml,xml let b:delimitMate_autoclose = 0

" Filetypes that need real tabs
autocmd FileType make :set ts=4 noet nolist
" Defaults for indentation detection
let g:detectindent_preferred_expandtab = 1
let g:detectindent_preferred_indent = 4
autocmd BufReadPost * :DetectIndent

" Filetypes where we want 2-character spaces
autocmd FileType css,rst,javascript,htmldjango,xhtml,html,xml,mail :set ts=2 sw=2 sts=2 et

" Get rid of this exceptionally annoying 'feature'
noremap q: <C-l>
noremap q? <C-l>

syntax on


" Set some formatoptions
set formatoptions=tcrqn

" Incremental search is good
set incsearch
set hlsearch
hi MatchParen cterm=NONE ctermfg=LightGreen ctermbg=NONE

" Disable highlighted search on redraw
map <silent> <C-l> :nohlsearch<CR>:redraw!<CR>

" ??
autocmd Syntax * syntax sync fromstart

filetype plugin on
filetype indent on
" set nosmartindent
" set cindent
" set autoindent

" Tell extended Python highlighter
let python_highlight_space_errors=1
let python_highlight_all=1

" Always show cursor position
set ruler

" Fucking visual-select copying to clipboard! WTF!
set clipboard=

" C-d when file-completing
set wildmenu

" Omni-complete settings
inoremap <Nul> <C-x><C-o>
inoremap <C-Space> <C-x><C-o>

" Default to using keyword completion
let g:SuperTabDefaultCompletionType = "<C-X><C-N>"
let g:SuperTabCrMapping = 0

let xml_use_xhtml = 1

highlight SpellBad cterm=NONE ctermfg=darkred ctermbg=none

" De-uglify omni-complete menu
highlight Pmenu cterm=NONE ctermfg=Grey ctermbg=Blue
highlight PmenuSel cterm=NONE ctermfg=White ctermbg=Blue

" Show trailing whitepace and spaces before a tab:
highlight ExtraWhitespace cterm=NONE ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/

" PySmell options and supertab integration
set completeopt=menuone,longest

" Change to working directory of current buffer. Very useful.
" set autochdir

" Configure syntastic code checking
let g:syntastic_enable_highlighting=1
let g:syntastic_enable_signs=0
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_config_file = '.clang_complete'
let g:syntastic_cpp_remove_include_errors = 1
let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['scala'] }

" Clang complete configuration
let g:clang_periodic_quickfix=0
let g:clang_library_path="/usr/lib"
let g:clang_use_library=1
let g:clang_complete_auto=0

" Round shifting to nearest shiftwidth
set shiftround

" Insert blanks according to shiftwidth
set smarttab

" Tab traversal
map <silent> <Tab> :wincmd w<CR>
map <silent> <C-Tab> :tabnext<CR>
map <silent> <C-S-Tab> :tabprevious<CR>
map <silent> <M-D-Right> :tabnext<CR>
map <silent> <M-D-Left> :tabprevious<CR>
map <silent> <D-1> 1gt
map <silent> <D-2> 2gt
map <silent> <D-3> 3gt
map <silent> <D-4> 4gt
map <silent> <D-5> 5gt
map <silent> <D-6> 6gt
map <silent> <D-7> 7gt
map <silent> <D-8> 8gt
map <silent> <D-9> 9gt

" Toggle comments
map <D-/> ,c<Space>

" Nerd tree
let NERDTreeQuitOnOpen=1
map <silent> <F2> :NERDTreeToggle<CR>

" Toggle headers
map <silent> <C-H> :FSHere<CR>
map <silent> <C-X> :bd<CR>

" Set colorscheme
colorscheme swapoff


" Disable toolbar
set go-=T

" Stuff for Rope - Yet again, buggy as hell.
"let $PYTHONPATH .= ":/Users/aat/Downloads/ropevim:/Users/aat/Downloads/ropemode"
"source /Users/aat/Downloads/ropevim/ropevim.vim

" Used for Command-T
" Open files in tabs
set wildignore=*.o,*.a,*.so,*.pyc,*~,*.class,build/*,build-*,tags,cscope*,third_party/*,java/*,users/*,data/*,3rdparty/*,*.jar,target/*,dist/*
map <silent> <C-J> <Leader>t

" Jump to a symbol from the CScope database: eg. :Sym Nilsimsa
command! -nargs=1 Sym cscope find g <args>

call pathogen#infect()
