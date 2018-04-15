
"
" Plugins
"

call plug#begin('~/.vim/plugged')

" whitespace highlight
Plug 'ntpeters/vim-better-whitespace'
" Coffee-script
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
" highlight XML tags
Plug 'spiritofsands/MatchTag', { 'for': ['eruby', 'html', 'xml', 'javascript'] }
" Typescript
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
" Linter
Plug 'w0rp/ale'
" Show colors
Plug 'chrisbra/Colorizer', { 'for': ['xdefaults', 'css', 'scss'] }
" Fzf
Plug '~/.fzf'
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
" Buffers as tabs
Plug 'ap/vim-buftabline'
" Remember last position
Plug 'farmergreg/vim-lastplace'
" Snippets
Plug 'SirVer/ultisnips', { 'for': ['c', 'cpp'] }
Plug 'honza/vim-snippets', { 'for': ['c', 'cpp'] }

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
noremap <F12> :update<CR>

" Buffers
set hidden
noremap <leader>= :enew<cr>
noremap <leader>0 :bnext<CR>
noremap <leader>9 :bprevious<CR>
noremap <leader>- :bp <BAR> bd #<CR>
noremap <leader>l :buffers<CR>:buffer<Space>

" Ctrl-P
noremap <leader>p :FZF<CR>

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

" avoid misspelling
nnoremap Q exit
nnoremap W write
nnoremap X xit


" Colours
set t_Co=256
"highlight! Visual term=reverse ctermbg=246
highlight Visual cterm=NONE ctermbg=20 ctermfg=NONE
highlight Search term=reverse cterm=NONE ctermfg=white ctermbg=172
highlight TabLine      ctermfg=white  ctermbg=241     cterm=NONE
highlight TabLineFill  ctermfg=white  ctermbg=241     cterm=NONE
highlight TabLineSel   ctermfg=white  ctermbg=25  cterm=NONE

" Buff tab line settings
let g:buftabline_numbers=2
let g:buftabline_indicators=1
let g:buftabline_plug_max=12
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>q <Plug>BufTabLine.Go(4)
nmap <leader>w <Plug>BufTabLine.Go(5)
nmap <leader>e <Plug>BufTabLine.Go(6)
nmap <leader>a <Plug>BufTabLine.Go(7)
nmap <leader>s <Plug>BufTabLine.Go(8)
nmap <leader>d <Plug>BufTabLine.Go(9)
nmap <leader>z <Plug>BufTabLine.Go(10)
nmap <leader>x <Plug>BufTabLine.Go(11)
nmap <leader>c <Plug>BufTabLine.Go(12)

" Linter settings
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:ale_c_gcc_options = '-I./sources/include'
let g:ale_c_clang_options = '-I./sources/include'
let g:ale_lint_delay = 0
let g:ale_fixers = {
  \   'javascript': ['eslint'],
  \   'ruby': ['rubocop']
  \}

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
