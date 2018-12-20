"
" Linters
"

" SHELL
"   npm i -g bash-language-server
"   sudo apt install shellcheck golang
"   shfmt
" TEXT
"   npm install -g alex proselint
" FRONTEND
"   sudo apt install tidy
"   npm install -g csslint prettier stylelint htmlhint eslint eslint-plugin-react babel-eslint babel-cli babel-preset-flow flow-bin
" BACKEND
"   gem install rails_best_practices brakeman reek rubocop fasterer
" C linters
"   sudo apt install cppcheck clang clang-tidy clang-format flawfinder gcc
"   cquery:
"       https://github.com/cquery-project/cquery/wiki/Building-cquery
"   cpplint:
"       sudo apt install --no-install-recommends python3-pip python3-setuptools
"       pip3 install wheel && pip3 install cpplint
" C++ specific linters
" sudo apt install clazy
"
" Cmake
"   pip3 install cmakelint


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
Plug '~/.local/lib/fzf'
Plug 'junegunn/fzf.vim'

" matchIT
" packadd! matchit

" autocompletion
Plug 'maralla/completor.vim'

" remember last position
Plug 'farmergreg/vim-lastplace'

" c coding
"Plug 'chazy/cscope_maps', { 'for': ['c', 'cpp'] }
Plug 'majutsushi/tagbar'

" camelcase spellcheck
Plug 'kmszk/CCSpellCheck.vim'

" TODO: snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" ctags
"   sudo apt inserts universal-ctags global
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

call plug#end()


"
" Plugins settings
"

" linter
let g:ale_echo_msg_format = '%linter%: %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let compiler_options = '-pedantic -Wall -Wextra -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Winit-self -Wmissing-declarations -Wmissing-include-dirs -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wshadow -Wsign-conversion -Wsign-promo -Wstrict-overflow=5 -Wswitch-default -Wundef -Werror -Wno-unused -Wno-deprecated-register'
let g:ale_cpp_gcc_options = compiler_options
let g:ale_cpp_clang_options = compiler_options
let g:ale_cpp_clangtidy_checks = ['-android-*', '-abseil-*', '-fuschia-*', '-llvm-*', '-mpi*', '-objc-*', '-zircon-*']
let g:ale_cpp_cppcheck_options = '--enable=all --std=c++14 --std=posix --inconclusive'
let g:ale_cpp_parse_makefile = 2
let g:ale_lint_delay = 100
let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'ruby': ['rubocop'],
  \   'cpp': ['clang-format'],
  \   'sh': ['shfmt'],
  \}
let g:ale_ruby_rubocop_options = '--parallel'

" tagbar
let g:tagbar_compact = 1
augroup vim_tagbar
  " autooopen
  autocmd FileType c,cpp nested :call tagbar#autoopen(0)
augroup END

" gtags
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

"
" Config options
"

" be improved
set nocompatible

" make backspace work like most other apps
set backspace=2

" columns in tab (display mode)
set tabstop=4

" tab inserts spaces
set expandtab

" autoindent width
set shiftwidth=4

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

" Wrap words at 80
set textwidth=80
set wrapmargin=2

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

" spellcheck
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
nmap <F8> :TagbarToggle<CR>

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

" ale
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
noremap <F1> :ALEDetail<CR>

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
"noremap <F1> <Nop>
"inoremap <F1> <Nop>

" spellchack
noremap <F5> :setlocal spell! spell?<CR>

"
" Colours
"

set t_Co=256
highlight Visual       ctermfg=NONE   ctermbg=20      cterm=NONE
highlight Search       ctermfg=16     ctermbg=172     cterm=NONE
highlight StatusLineNC ctermfg=249    ctermbg=237     cterm=none
highlight VertSplit    ctermfg=237    ctermbg=249
highlight SpellBad     ctermfg=black  ctermbg=147    cterm=underline
highlight CCSpellBad   ctermfg=black  ctermbg=147    cterm=underline
