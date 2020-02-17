" ------------------------------------- PLUGIN MANAGEMENT ------------------------------------- "

let plug=expand($HOME.'/.vim/autoload/plug.vim')
if !filereadable(plug)
  echo "Installing Plugin manager.."
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin('~/.vim/plugins')
  Plug 'mhinz/vim-signify'
  Plug 'alcesleo/vim-uppercase-sql'
  Plug 'fatih/vim-go'
  Plug 'sheerun/vim-polyglot'
  Plug 'heavenshell/vim-jsdoc'
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'vim-scripts/colorizer'
  Plug 'w0rp/ale', { 'do': 'sudo pacman -S shellcheck typescript'}
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'alvan/vim-closetag'
  Plug 'Raimondi/delimitMate'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
  Plug 'vighd/vim-pgsql-query', { 'branch': 'development' }
call plug#end()
" ------------------------------------- PLUGIN SETTINGS ------------------------------------- "

" ALE
let g:ale_completion_enabled = 1
let g:ale_lint_delay = 800
let g:ale_javascript_prettier_options = '--jsx-single-quote --single-quote --tab-width 2 --no-semi --print-width 100'
let g:ale_sql_pgformatter_options = '-B -f 2 -g -s 2 -t -u 2 -W 1 -p ''(LANGUAGE)|(RETURNS)'''
let g:ale_go_langserver_executable = '/home/vighd/go/bin/go-langserver'
let g:ale_sql_pgformatter_executable = '/usr/local/bin/pg_format'
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['prettier'],
\   'json': ['prettier'],
\   'go': ['gofmt'],
\   'sql': ['pgformatter'],
\   'sh': ['shfmt'],
\} 
let b:ale_linters = {'javascript': ['eslint']}

" Vim-GO
let g:go_gocode_unimported_packages = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
let g:go_fmt_autosave = 0

" Closetag
let g:closetag_filenames = '*.html,*.js'

" DelimitMate
let g:delimitMate_balance_matchpairs = 1

" Polyglot
let g:sql_type_default = 'pgsql'
let g:pgsql_pl = ['javascript']

" ------------------------------------- FUNCTIONS ------------------------------------- "

let g:branch=system("cd ". expand('%:p:h') ." && git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")

function! _mode()
  hi MatchParen  guibg=#5E5F63 guifg=#82b1ff 
  hi NormFont    guifg=#5E5F63 guibg=#292D3E
  if mode() == 'i'
    hi Mode  guifg=#292D3E guibg=#82B1FF
    hi SLine guifg=#82B1FF guibg=#3E4452
    return 'INSERT'
  elseif mode() == 'n'
    hi Mode  guifg=#292D3E guibg=#C792EA
    hi Sline guifg=#C792EA guibg=#3E4452
    return 'NORMAL'
  elseif mode() == 'V'
    hi Mode  guifg=#292D3E guibg=#89DDFF
    hi Sline guifg=#89DDFF guibg=#3E4452
    return 'VISUAL'
  elseif mode() =~ '\v(r|R)'
    hi Mode  guifg=#292D3E guibg=#C3E88D
    hi Sline guifg=#C3E88D guibg=#3E4452
    return 'RPLACE'
  elseif mode() =~ 't'
    hi Mode  guifg=#292D3E guibg=#FFE585
    hi Sline guifg=#FFE585 guibg=#3E4452
    return ' TERM '
  else
    hi Mode  guifg=#292D3E guibg=#89DDFF
    hi Sline guifg=#89DDFF guibg=#3E4452
    return 'VBLOCK'
  endif
endfunction

" ------------------------------------- GENERAL SETTINGS ------------------------------------- "

set laststatus=2                    " always show statusline
set statusline=%#Mode#\ %-07.8{_mode()}%#SLine#\ %{g:branch}\ %f\ %M\ %#NormFont#%=%y\ \|\ %{&fileencoding?&fileencoding:&encoding}\ \|\ [%{&fileformat}\]\ %#SLine#\ %-04(%p%%%)\ %-09.9(%#Mode#\ %=%l:%c%)
set t_Co=256
syntax enable
set nocompatible
filetype plugin indent on
setglobal fileencoding=utf-8
set viewoptions=cursor,folds,slash,unix
"set mouse=a
set encoding=utf-8
set timeoutlen=500                  " time waited for key press(es) to complete. It makes for a faster key response
set ttimeoutlen=0
set autoread                        " Set to auto read when a file is changed from the outside
set backspace=2                     " make backspace work normal
set diffopt=foldcolumn:0,filler     " Add vertical spaces to keep right and left aligned
set diffopt+=iwhite                 " Ignore whitespace changes (focus on code changes)
set gdefault                        " regex /g by default
set hid                             " you can change buffers without saving
set nostartofline                   " don't jump to first character when paging
set ttyfast                         " smoother changes
set noerrorbells                    " No noise.
set vb t_vb=                        " disable any beeps or flashes on error
set novisualbell                    " No blinking
set fileformats=unix,dos,mac        " set compatible line endings in order of preference
set cmdheight=1                     " the command bar is 1 high
set equalalways                     " Close a split window in Vim without resizing other windows
set linespace=0                     " space it out a little more (easier to read)
set number                          " turn on line numbers
set showmode                        " If in Insert, Replace or Visual mode put a message on the last line.
set wildmenu                        " nice tab-completion on the command line
set wildchar=9                      " tab as completion character
set guitablabel=%t
set complete-=i
set completeopt+=menuone,noselect,noinsert,longest
"set completeopt-=preview
set pumheight=10
set path=**                         " Add all files and folders to the path
set wildmode=longest:full,list:full
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,.svn,*.gem,*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.swp,*~,._*,*/node_modules/*,*/data/*,*/.git/*,*/dist/*,*/build/*
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pdf,.exe
set termguicolors                   " Enables 24bit coloring
set background=dark
set redrawtime=10000
set relativenumber
set listchars=tab:\⎢\ ,trail:·,extends:…,precedes:…
colorscheme palenight
set nobackup                        " disables backup file
set nowb                            " disables backup file writing
set noswapfile                      " disables swapfile
set undodir=$HOME/.vim/.undofile
set undofile
set undolevels=1000                 " maximum number of changes that can be undone
set undoreload=10000                " maximum number lines to save for undo on a buffer reload
if ! isdirectory(&undodir)
  call mkdir(&undodir, 'p')
endif
set display=lastline                " don't display @ with long paragraphs
set splitbelow                      " Puts new split windows to the bottom of the current
set splitright                      " Puts new vsplit windows to the right of the current
set autoindent                      " Keep the indent when creating a new line
set copyindent                      " Copy the previous indentation on autoindent
set expandtab                       " Spaces instead of tabs for better cross-editor compatibility
set shiftwidth=2                    " Number of spaces to use in each autoindent step
set smarttab                        " Use shiftwidth and softtabstop to insert or delete (on <BS>) blanks
set softtabstop=2                   " Number of spaces to skip or insert when <BS>ing or <Tab>ing
set tabstop=2                       " Two tab spaces
set hlsearch                        " highlight all matches...
set ignorecase                      " select case-insenitiv search
set incsearch                       " ...and also during entering the pattern
set magic                           " change the way backslashes are used in search patterns
"set matchpairs+=<:>                 " these tokens belong together
set matchtime=2                     " How many tenths of a second to blink
set showmatch                       " jump to matches during entering the pattern
set smartcase                       " No ignorecase if Uppercase chars in search
nohlsearch                          " avoid highlighting when reloading vimrc
set display=lastline                " don't display @ with long paragraphs
set formatoptions=roqnl12           " How automatic formatting is to be done
set lbr                             " line break
set nojoinspaces                    " Prevents inserting two spaces after punctuation on a join (J)
set nowrap                          " word wrap
set splitbelow                      " Puts new split windows to the bottom of the current
set splitright                      " Puts new vsplit windows to the right of the current
set textwidth=0                     " Disables the maximum width of text that is being inserted
set wrapscan                        " Searches wrap around end of file

" ------------------------------------- KEY MAPPINGS ------------------------------------- "

" Map F1 with <Esc>
map <F1> <Esc>
imap <F1> <Esc>
" Search and replace with rr
noremap rr :%s/
" JSDOC with <F4>
nmap <silent> <F4> <Plug>(jsdoc)
" Clear search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR> :syntax sync fromstart<CR><C-l>
" Change tabs with LAlt+Left/Right
nnoremap <M-Right> :tabn<CR>
nnoremap <M-Left> :tabp<CR>
" Call psql with the current buffer
nnoremap <F9> :call RunPGSQLQuery()<CR>
xnoremap <F9> :call RunPGSQLVisualQuery()<CR>
xnoremap <S-F9> :call RunPGSQLQueryToCsv()<CR>
xnoremap <C-F9> :call RunPGSQLVisualQueryAsJSON()<CR>
" Run macro in visual mode with .
xnoremap . :normal @q<CR>
" Reload vimrc with F5
nnoremap <F5> :source $HOME/.vimrc<CR>
" ALEFix
nnoremap <F4> :ALEFix<CR>
" Remap file finder base on the buffer name
nnoremap <expr> ff bufname("%") == "" ? ':find ' : ':tabfind '
" Move cursor without moving the screen
nnoremap <c-j> 5jzz
nnoremap <c-k> 5kzz
" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>
" Git blame
nnoremap gb :echomsg system("git blame -L ".line(".").",".line(".")." ".expand("%"))[:-2]<CR>
" Select autocompletion with j-k
inoremap <expr> j ((pumvisible())?("\<C-n>"):("j"))
inoremap <expr> k ((pumvisible())?("\<C-p>"):("k"))
" Remap TAB to change tab o.O
noremap <TAB> gt
noremap <S-TAB> gT
" Surround
xnoremap " c"<c-r>""<Esc>
xnoremap ' c'<c-r>"'<Esc>
xnoremap ` c`<c-r>"`<Esc>
xnoremap { c{<c-r>"}<Esc>
xnoremap ( c(<c-r>")<Esc>
xnoremap [ c[<c-r>"]<Esc>

" ------------------------------------- AUTOCOMMANDS ------------------------------------- "

" when enabling diff for a buffer it should be disabled when the buffer is not visible anymore
au BufHidden * if &diff == 1 | diffoff | setlocal nowrap | endif

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Fix styled components syntax hl at start
au BufEnter * :syntax sync fromstart

" ECDMS Filetype
au BufRead,BufNewFile *.ecdms set filetype=ecdms

"Omnifuncs
au FileType sql set omnifunc=syntaxcomplete#Complete
au FileType vim set omnifunc=syntaxcomplete#Complete
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Backup vimrc on write
au BufWrite .vimrc execute system("cp $HOME/.vimrc $HOME/.local/.vimrc_bckp")

" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
