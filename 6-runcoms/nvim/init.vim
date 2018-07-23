" --- Settings to enable vundle functionality ---
filetype off				" Required by Vundle
set rtp+=~/.config/nvim/bundle/Vundle.vim	" Set the runtime path and initialize
call vundle#rc('~/.config/nvim/bundle')	" Set plugin install location
call vundle#begin()			" Required by Vundle
Plugin 'VundleVim/Vundle.vim'		" Let Vundle manage Vundle, required

" --- Vundle Plugins ---
Plugin 'ap/vim-buftabline'

" This might not be neccessary with nerdtree... but I was hoping to get rid of
" nerd tree in exchange for decent file manager anyways...

Plugin 'scrooloose/nerdtree'		" Provides a file tree
Plugin 'vim-syntastic/syntastic'	" Provides error checking
Plugin 'lervag/vimtex'			" LaTex support and comilation in nvim
Plugin 'morhetz/gruvbox'		" Theme
"Plugin 'jaxbot/browserlink.vim'     " Auto-synchronisation for web development
Plugin 'shougo/deoplete.nvim'

Plugin 'euclio/vim-markdown-composer'

" --- More Settings to enable vundle
call vundle#end()			" Required by Vundle
filetype plugin indent on		" Required by Vunle

" --- General settings ---
set backspace=indent,eol,start
set spell              " spell checking
set wrap                " soft word wrapping
set linebreak           " only wrap in appropriate places
set nolist              " list disables linebreak
set breakindent         " preserves formatting when wrapping
set breakindentopt=shift:2 " shifts formatted wrap by 2 characters to indicate presence of wrapping
set ruler
set number
set showcmd
set incsearch
set hlsearch
"set hidden				" Permits 'hiding' of edited buffers
set splitbelow
set splitright				" Opens panes to right and bottom, rather than top and left
nmap <leader>q :nohlsearch<CR>		" Binding to clear search highlighting


nnoremap <C-J> <C-W><Down>		" Remap bindings to make pane switching easier
nnoremap <C-K> <C-W><Up>
nnoremap <C-_> <C-W><Right> " translated from <C-_> according to http://vim.wikia.com/wiki/Unused_keys
nnoremap <C-L> <C-W><Left>

" Navigation settings
" using [ down, up | left, right ] to utilize all four fingers
noremap l <Left>
noremap ; <Right>
noremap h ;

"nnoremap <silent> <c-l> :call Focus('right', 'l')<CR>
"nnoremap <silent> <c-h> :call Focus('left', 'h')<CR>
"nnoremap <silent> <c-k> :call Focus('up', 'k')<CR>
"nnoremap <silent> <c-j> :call Focus('down', 'j')<CR>

syntax on				" syntax highlighting
set mouse=a				" enables scrolling and clicking, etc.

set number relativenumber   " show relative line numbers and absolute current line

augroup numbertoggle    " automatically disable hybrid line numbers when not interacting in a relevant way with the buffer
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * if &filetype != "nerdtree" | set relativenumber | endif
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

set termguicolors			" enabling theme
colorscheme gruvbox			" choosing theme
set background=dark			" Choosing dark mode

" Use python syntax highlighting for dssl2 files (EECS-214, Tov)
"au BufEnter *.rkt if getline(1) == "#lang dssl2" | set syntax=python | endif

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab




" --- Plugin-Specific Settings ---

"vim-markdown-composer
let markdown_composer_browser='qutebrowser'

" ----- scrooloose/nerdtree -----
nmap <silent> <leader>t :NERDTreeToggle<CR> " Open/close NERDTree with \t

" Open NERDTree on startup
autocmd vimenter * NERDTree 			
" Open NERDTree when starting with command line arguments -> want to make it
" close unless condition met
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() != 0 || exists("s:std_in") | NERDTreeToggle

let g:NERDTreeWinSize=30			" Set NERDTree size
let NERDTreeShowLineNumbers=0
autocmd FileType nerdtree setlocal norelativenumber

" close vim when last window is NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"
" Problems:
"   The NERDTree buffer takes b2. Accessing b2 as the only pane quits nvim.
"   Accessing b2 as one of multiple panes breaks its sizing.
"

" --- scrooloose/syntastic settings ---
let g:syntastic_error_symbol = '✘'
let g:syntastic_warning_symbol = "▲"
augroup mySyntastic
  au!
  au FileType tex let b:syntastic_mode = "passive"
augroup END

" --- deoplete
let g:deoplete#enable_at_startup = 1
"if !exists('g:deoplete#omni#input_patterns')
"  let g:deoplete#omni#input_patterns = {}
"endif
let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" tab-complete using deoplete to extend built in functionality
"   cycle through suggestions using tab or shift tab
function! InsertTabWrapper()
    let col = col('.') - 1
    " If inside of the completion menu, cycle down it
    if pumvisible()
        return "\<c-n>"
    else
        " If the current character is a period, open completion
        if getline('.')[col - 1] == '.'
            return "\<c-x>\<c-p>"
        " If we're not at the end of a word, just tab
        elseif !col || getline('.')[col - 1] !~ '\k'
            return "\<tab>"
        " If we are the end of a word, open completion
        else
            return "\<c-x>\<c-p>"
        endif
    endif
endfunction
inoremap <expr> <tab> InsertTabWrapper()
inoremap <s-tab> <c-p>
