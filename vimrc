
"
" Plugins
"

call plug#begin('~/.vim/plugged')

" whitespace highlight
Plug 'ntpeters/vim-better-whitespace'

" Coffee-script
"Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" highlight XML tags
Plug 'spiritofsands/MatchTag', { 'for': ['eruby', 'html', 'xml', 'javascript'] }

" Typescript
"Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }

" Linter
Plug 'w0rp/ale'

" Show colors
"Plug 'chrisbra/Colorizer', { 'for': ['xdefaults', 'css', 'scss'] }

" Fzf
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" MatchIT
packadd! matchit

" SHELL linters
" sudo apt install shellcheck
"
" TEXT linters
" npm install -g alex proselint
"
" FRONTEND linters
" sudo apt install tidy
" npm install -g csslint prettier stylelint htmlhint eslint eslint-plugin-react babel-eslint babel-cli babel-preset-flow flow-bin
"
" BACKEND linters
" gem install rails_best_practices brakeman reek rubocop fasterer
"
" C linters
" sudo apt install cppcheck clang clangtidy clang-format flawfinder gcc
" sudo apt install --no-install-recommends python-pip python3-setuptools
" pip install wheel
" pip install cpplint

" Autocompletion
Plug 'maralla/completor.vim'

" Remember last position
Plug 'farmergreg/vim-lastplace'

" Snippets
"Plug 'SirVer/ultisnips', { 'for': ['c', 'cpp'] }
"Plug 'honza/vim-snippets', { 'for': ['c', 'cpp'] }

" Kernel coding
Plug 'chazy/cscope_maps', { 'for': ['c', 'cpp'] }
Plug 'vivien/vim-linux-coding-style', { 'for': ['c', 'cpp'] }
Plug 'majutsushi/tagbar'

call plug#end()

"
" Config options
"

" be improved
set nocompatible
" make backspace work like most other apps
set backspace=2
" columns in tab (display mode)
set tabstop=2
" tab inserts spaces
set expandtab
" autoindent width
set shiftwidth=2
" syntax highlighting
syntax on
" highlight search items
set hlsearch
" no text truncating
set textwidth=0

"
" Mappings
"

" Leader key
let mapleader = "\<Space>"
" Subst mapping
:nnoremap <Leader><S-s> :%s/\<<C-r><C-w>\>/

" Vim explorer mappings
noremap <leader>r :Explore<cr>
noremap <leader><S-r> :Rexplore<cr>

" Shortcuts
noremap <C-S> :update<CR>
noremap <F10> :ALEFix<CR>

" Buffers
set hidden
noremap <leader>= :enew<cr>
noremap <leader>0 :bnext<CR>
noremap <leader>9 :bprevious<CR>
noremap <leader>- :bp <BAR> bd #<CR>
noremap <leader>l :buffers<CR>:buffer<Space>

" FZF
noremap <leader>p :FZF<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>h :History<CR>

" Disable arrow keys
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Disable bindings
map q: <Nop>
nnoremap Q <Nop>
nnoremap <F1> <Nop>

" Colours
set t_Co=256
"highlight! Visual term=reverse ctermbg=246
highlight Visual cterm=NONE ctermbg=20 ctermfg=NONE
highlight Search term=reverse cterm=NONE ctermfg=white ctermbg=172
highlight TabLine      ctermfg=white  ctermbg=241     cterm=NONE
highlight TabLineFill  ctermfg=white  ctermbg=241     cterm=NONE
highlight TabLineSel   ctermfg=white  ctermbg=25  cterm=NONE

" Linter settings
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_c_gcc_options = '-O1 -Wall -Wextra -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wstrict-prototypes -Wstrict-overflow=5 -Wwrite-strings -Waggregate-return -Wcast-qual -Wswitch-default -Wswitch-enum -Wconversion -Wunreachable-code -Wformat=2 -Werror-implicit-function-declaration -fsanitize=address -fsanitize=signed-integer-overflow'
let g:ale_c_parse_makefile = 1
let g:ale_lint_delay = 100
let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'ruby': ['rubocop']
  \}
let g:ale_ruby_rubocop_options = '--parallel'

" Completer settings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" Disable bell
set visualbell

" Snippets engine config
let g:UltiSnipsExpandTrigger="<leader><tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" Undo file
set undofile
set undodir=~/.vim/undo
set undolevels=1000
set undoreload=1000

" Quickly add empty lines
nnoremap [<space>  :<c-u>put! =repeat(nr2char(10), v:count1)<cr>
nnoremap ]<space>  :<c-u>put =repeat(nr2char(10), v:count1)<cr>

" Tagbar
let g:tagbar_compact = 1
autocmd FileType c,cpp nested :call tagbar#autoopen(0)
nnoremap <silent> <F10> :TagbarToggle<CR>
