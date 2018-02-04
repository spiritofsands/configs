
"
" Plugins
"

call plug#begin('~/.vim/plugged')

" whitespace highlight
Plug 'ntpeters/vim-better-whitespace'
" Coffee-script
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }
" highlight XML tags
Plug 'gregsexton/MatchTag', { 'for': ['eruby', 'html', 'xml'] }
" Linter
Plug 'w0rp/ale'

" used:
" sudo apt intall shellcheck tidy rails_best_practices reek
" sudo npm install -g csslint prettier stylelint alex htmlhint proselint eslint babel-cli babel-preset-flow flow-bin jshint standard
" # setup rbenv
" gem install rails_best_practices brakeman reek rubocop

" Autocompletion
Plug 'maralla/completor.vim'
" Buffers as tabs
Plug 'ap/vim-buftabline'
" Ctrl+P
Plug 'ctrlpvim/ctrlp.vim'

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
noremap <leader>c :enew<cr>
noremap <leader>n :bnext<CR>
noremap <leader>b :bprevious<CR>
noremap <leader>x :bp <BAR> bd #<CR>

" Ctrl-P
noremap <Leader>p :CtrlP<CR>
let g:ctrlp_custom_ignore = {
  \ 'dir':  'node_modules$',
  \ }

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
:command Q exit
:command W write
nnoremap X xit


" Colours
set t_Co=256
"highlight! Visual term=reverse ctermbg=246
highlight Visual cterm=NONE ctermbg=20 ctermfg=NONE
highlight Search term=reverse cterm=NONE ctermfg=white ctermbg=172
highlight TabLine      ctermfg=white  ctermbg=241     cterm=NONE
highlight TabLineFill  ctermfg=white  ctermbg=241     cterm=NONE
highlight TabLineSel   ctermfg=white  ctermbg=25  cterm=NONE
let g:buftabline_numbers=2
let g:buftabline_indicators=1
let g:buftabline_plug_max=9
nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>q <Plug>BufTabLine.Go(4)
nmap <leader>w <Plug>BufTabLine.Go(5)
nmap <leader>e <Plug>BufTabLine.Go(6)
nmap <leader>a <Plug>BufTabLine.Go(7)
nmap <leader>s <Plug>BufTabLine.Go(8)
nmap <leader>d <Plug>BufTabLine.Go(9)


" Linter settings
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1

" Completer settings
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"

" set paste no more
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"

" Disable bell
set visualbell

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction
