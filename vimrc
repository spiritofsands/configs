"
" Linters
"

" SHELL
"   bash-language-server: wget https://git.io/n-install
"                         bash n-install -n -y
"                         npm i bash-language-server
"   shellcheck: sudo apt install shellcheck
"   shfmt: sudo add-apt-repository ppa:gophers/archive
"          sudo apt update
"          sudo apt install golang-1.11-go
"          sudo ln -s /usr/lib/go-1.11/bin/go /usr/bin/go
"          cd $(mktemp -d); go mod init tmp; go get mvdan.cc/sh/cmd/shfmt
"
" TEXT
"   npm install alex proselint
"
" WEB FRONTEND
"   sudo apt install tidy
"   npm install csslint prettier stylelint htmlhint eslint eslint-plugin-react babel-eslint babel-cli babel-preset-flow flow-bin
"
" RUBY
"   gem install --user-install rails_best_practices brakeman reek rubocop fasterer
"
" C
"   sudo apt install cppcheck flawfinder clang clang-tidy clang-format gcc
"   cquery:
"       https://github.com/cquery-project/cquery/wiki/Building-cquery
"   cpplint:
"       sudo apt install --no-install-recommends python3-pip python3-setuptools
"       pip3 install wheel && pip3 install cpplint
"
" C++ specific linters
" sudo apt install clazy
"
" CMAKE
"   pip3 install cmakelint
"
" PYTHON
"   pip3 install yapf flake8 mypy pylint mccabe pyflakes pylama pycodestyle pydocstyle
"


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
Plug '~/bin/etc/fzf'
Plug 'junegunn/fzf.vim'

" matchIT
" packadd! matchit

" autocompletion
" python3 -m pip install jedi
Plug 'maralla/completor.vim'

" remember last position
Plug 'farmergreg/vim-lastplace'

" c coding
"Plug 'chazy/cscope_maps'
"Plug 'joereynolds/gtags-scope'
Plug 'majutsushi/tagbar'

" camelcase spellcheck
Plug 'kmszk/CCSpellCheck.vim'
Plug 'shinglyu/vim-codespell'

" TODO: snippets
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'

" ctags
"   sudo apt install universal-ctags global
"Plug 'ludovicchabant/vim-gutentags'
"Plug 'skywind3000/gutentags_plus'

" ranger
Plug 'francoiscabrol/ranger.vim'

" vim & tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" python code coverage
Plug 'mgedmin/coverage-highlight.vim', { 'for': ['python'] }

" python indentation
Plug 'Vimjas/vim-python-pep8-indent', { 'for': ['python'] }

call plug#end()


"
" Plugins settings
"

" linter
let g:ale_echo_msg_format = '%linter%: %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let compiler_options = '--std=c++14 -pedantic -Wall -Wextra -Wcast-align -Wcast-qual -Wctor-dtor-privacy -Wdisabled-optimization -Wformat=2 -Winit-self -Wmissing-declarations -Wmissing-include-dirs -Wold-style-cast -Woverloaded-virtual -Wredundant-decls -Wshadow -Wsign-conversion -Wsign-promo -Wstrict-overflow=5 -Wswitch-default -Wundef -Werror -Wno-unused -Wno-deprecated-register'
let g:ale_cpp_gcc_options = compiler_options
let g:ale_cpp_clangd_options = '-isystem'
let g:ale_cpp_clang_options = compiler_options
let g:ale_cpp_clangtidy_checks = ['-android-*', '-abseil-*', '-fuchsia-*', '-llvm-*', '-mpi*', '-objc-*', '-zircon-*', '-modernize-use-trailing-return-type', '-llvmlibc-*']
let g:ale_cpp_cppcheck_options = '--enable=all --std=c++14 --std=posix --inconclusive --inline-suppr'
let g:ale_cpp_parse_makefile = 2
let g:ale_lint_delay = 100
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'c*': ['clang-format'], 'python': ['yapf'] }
let g:ale_fix_on_save = 1
let g:ale_linters = {'python': ['flake8', 'mypy', 'pylint', 'prospector', 'pyflakes', 'pylama', 'pycodestyle', 'pydocstyle']}
let g:ale_ruby_rubocop_options = '--parallel'
let g:ale_c_parse_makefile = 1

" tagbar
let g:tagbar_compact = 1

" gtags
let g:gutentags_modules = ['ctags', 'gtags_cscope']
let g:gutentags_cache_dir = expand('~/.vim/gutentags/tags-cache')
let g:gutentags_plus_switch = 1
"let g:gutentags_modules = []
"if executable('ctags')
"    let g:gutentags_modules += ['ctags']
"endif
"if executable('gtags-cscope') && executable('gtags')
"    let g:gutentags_modules += ['gtags_cscope']
"endif
let g:gutentags_cache_dir = expand('~/.vim/gutentags')

"
" Config options
"

" be improved
set nocompatible

" make subst global
set gdefault

" display current symbol
set ruler

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
set undodir=~/.vim/undo/
set undolevels=1000
set undoreload=1000

" clean shell
set shell=~/bin/clean-shell-wrapper.sh

" spellcheck
syntax spell toplevel
set spell spelllang=en_us
hi clear SpellBad
hi SpellBad cterm=underline
hi clear SpellRare
hi SpellRare cterm=underline
hi clear SpellCap
hi SpellCap cterm=underline
hi clear SpellLocal
hi SpellLocal cterm=underline
noremap <F5> :setlocal spell! spell?<CR>


" ranger
let g:ranger_map_keys = 0
let g:ranger_replace_netrw = 1
let g:ranger_command_override = 'ranger'

" completor
let g:completor_python_binary = "/usr/bin/python3"

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> h :TmuxNavigateLeft<cr>
nnoremap <silent> j :TmuxNavigateDown<cr>
nnoremap <silent> k :TmuxNavigateUp<cr>
nnoremap <silent> l :TmuxNavigateRight<cr>
" nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

"
" Mappings
"

" leader key
let mapleader = "\<Space>"

" subst mapping
noremap <Leader><S-s> :%s/\<<C-r><C-w>\>/<C-r><C-w>

" shortcuts
noremap <C-S> :update<CR>
inoremap <C-S> <Esc>:update<CR>
noremap <F10> :ALEFix<CR>
nmap <F8> :TagbarToggle<CR>

" buffers and splits
noremap <leader>- :new<CR>
noremap <leader>\ :vnew<CR>

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

" ranger
noremap <leader>r :Ranger<CR>

"
" Colors
"

set t_Co=256
highlight Visual                 ctermfg=NONE   ctermbg=20      cterm=NONE
highlight Search                 ctermfg=16     ctermbg=172     cterm=NONE
highlight StatusLineNC           ctermfg=249    ctermbg=237     cterm=none
highlight VertSplit              ctermfg=237    ctermbg=249

let g:CCSpellCheckMatchGroupName = 'SpellBad'
highlight SpellBad               cterm=underline

highlight NoCoverage             ctermbg=052
highlight NoBranchCoverage       ctermbg=052
highlight NoBranchCoverageTarget ctermbg=052
