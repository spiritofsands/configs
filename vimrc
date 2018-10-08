"
" Linters
"

" SHELL
"   sudo apt install shellcheck
" TEXT
"   npm install -g alex proselint
" FRONTEND
"   sudo apt install tidy
"   npm install -g csslint prettier stylelint htmlhint eslint eslint-plugin-react babel-eslint babel-cli babel-preset-flow flow-bin
" BACKEND
"   gem install rails_best_practices brakeman reek rubocop fasterer
" C linters
"   sudo apt install cppcheck clang clangtidy clang-format flawfinder gcc
"   sudo apt install --no-install-recommends python-pip python3-setuptools
"   pip install wheel
"   pip install cpplint


"
" Plugins
"

call plug#begin('~/.vim/plugged')

" whitespace highlight
Plug 'ntpeters/vim-better-whitespace'

" highlight XML tags
" Plug 'spiritofsands/MatchTag', { 'for': ['eruby', 'html', 'xml', 'javascript'] }

" linter
Plug 'w0rp/ale'

" fzf
Plug '~/.fzf'
Plug 'junegunn/fzf.vim'

" matchIT
" packadd! matchit

" autocompletion
Plug 'maralla/completor.vim'

" remember last position
Plug 'farmergreg/vim-lastplace'

" kernel coding
Plug 'chazy/cscope_maps', { 'for': ['c', 'cpp'] }
Plug 'majutsushi/tagbar'

" camelcase spellcheck
"Plug 'kmszk/CCSpellCheck.vim'

" TODO: snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
call plug#end()


"
" Plugins settings
"

" linter
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
" let kdir = ' -I/home/kos/kernel_dev/src/linux-stable/include -I/home/kos/kernel_dev/src/linux-stable/arch/arm/include'
" let compiler_options = '-O1 -Wall -Wextra -Wfloat-equal -Wundef -Wshadow -Wpointer-arith -Wcast-align -Wstrict-prototypes -Wstrict-overflow=5 -Wwrite-strings -Waggregate-return -Wcast-qual -Wswitch-default -Wswitch-enum -Wconversion -Wunreachable-code -Wformat=2 -Werror-implicit-function-declaration -fsanitize=address -fsanitize=signed-integer-overflow'
" let g:ale_c_gcc_options = compiler_options . kdir
" let g:ale_c_clang_options = g:ale_c_gcc_options . kdir
" let g:ale_c_clangtidy_options = g:ale_c_clang_options
" let g:ale_c_clangcheck_options = g:ale_c_clang_options
" let g:ale_c_cppcheck_options = kdir
let g:ale_c_parse_makefile = 1
let g:ale_lint_delay = 100
" fixme
let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'ruby': ['rubocop'],
  \   'cpp': ['clang-format']
  \}
let g:ale_pattern_options = {
  \   'src/linux/': {
  \     'ale_linters': ['']
  \   },
  \}
let g:ale_ruby_rubocop_options = '--parallel'

" tagbar
let g:tagbar_compact = 1
nmap <F8> :TagbarToggle<CR>
autocmd FileType * nested :call tagbar#autoopen(0)


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

" disable bell
set visualbell

" allow hidden modified buffers
set hidden

" splits
set splitbelow
set splitright
set statusline=─
set fillchars=stl:─
set fillchars+=stlnc:─
set fillchars+=vert:│
augroup CursorLineOnlyInActiveWindow
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" undo file
set nobackup
set noswapfile
set undofile
set undodir=/home/kos/.vim/undo//
set undolevels=1000
set undoreload=1000

" clean shell
set shell=~/bin/clean-shell-wrapper.sh

" spellcheck goodOne
syntax spell toplevel
"set spell spelllang=en_us


"
" Mappings
"

" leader key
let mapleader = "\<Space>"

" subst mapping
noremap <Leader><S-s> :%s/\<<C-r><C-w>\>/<C-r><C-w>

" vim explorer mappings
noremap <leader>r :Explore<cr>
noremap <leader><S-r> :Rexplore<cr>

" shortcuts
noremap <C-S> :update<CR>
inoremap <C-S> <Esc>:update<CR>
noremap <F10> :ALEFix<CR>

" buffers and splits
noremap <leader>= :enew<cr>
noremap <leader>- :bp <BAR> bd #<CR>
noremap <leader>l :<CR>:buffer<Space>
noremap <C-W>- :split
noremap <C-W>\ :vsplit

" fzf
noremap <leader>p :FZF<CR>
noremap <leader>b :Buffers<CR>
noremap <leader>h :History<CR>

" completer
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" quickly add empty lines
noremap <space><space> o<Esc>

" disabled bindings
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
noremap q: <Nop>
noremap Q <Nop>
noremap <F1> <Nop>
inoremap <F1> <Nop>

" spellchack
inoremap <F5> :setlocal spell! spell?<CR>

"
" Colours
"

set t_Co=256
highlight Visual       ctermfg=NONE   ctermbg=20      cterm=NONE
highlight Search       ctermfg=16     ctermbg=172     cterm=NONE
highlight StatusLineNC ctermfg=249    ctermbg=237     cterm=none
highlight VertSplit    ctermfg=237    ctermbg=249
highlight SpellBad     ctermfg=black  ctermbg=147    cterm=underline
"highlight CCSpellBad   ctermfg=black  ctermbg=147    cterm=underline
