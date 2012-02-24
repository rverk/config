colorscheme desert  
set ignorecase      " ignore case when searching
set number          " show line numbers 

" Enable Plugins
filetype plugin on
filetype plugin indent on
let g:pydiction_location='/home/rob/.vim/after/ftplugin/pydiction/complete-dict'

"A tab is always 4 spaces
set tabstop=4	
set shiftwidth=4
set expandtab

set hlsearch	"highlight search results
set nowrap		"disable line wrapping

"Space twice to remove search highlights
nmap <SPACE> <SPACE>:noh<CR>

"Set font and size
set gfn=Monospace\ 9

"switch buffers without having to save them first
set hidden

" Make the 'cw' and like commands put a $ at the end instead of just deleting
" the text and replacing it
"set cpoptions=ces$

" Toggle fullscreen mode
nmap <silent> <F3> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

" Set the status line and force setting it 
" set stl=%f\ %m\ %r%{fugitive#statusline()}\ Line:%l/%L[%p%%]\ Col:%v\ Buf:#%n\ [%b][0x%B]
set stl=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 

"show current mode
set showmode

"Keep history
set history=100

" When the page starts to scroll, keep the cursor 8 lines from the top and 8 lines from the bottom
set scrolloff=8

" Set the textwidth to be 80 chars
" set textwidth=80

" Add ignorance of whitespace to diff
set diffopt+=iwhite

" Automatically read a file that has changed on disk
set autoread

" When a file has a header with a "#!", like #!/bin... chmod +x the file after write
au BufWritePost * if getline(1) =~ "^#!" | if getline(1) =~ "/bin/" | silent !chmod u+x <afile> | endif | endif

" Apache Pig Script
augroup filetypedetect
  au BufNewFile,BufRead *.pig set filetype=pig syntax=pig
augroup END 

" Stop creating swapfiles
set noswapfile

" Insert timestamp with F3
nmap <F3> a<C-R>=strftime("%Y-%m-%d")<CR><Esc>
imap <F3> <C-R>=strftime("%Y-%m-%d")<CR>

" Compile and view reStructuredText document
command Rst :!rst2html % > /tmp/rstprev.html && firefox /tmp/rstprev.html
nnoremap <C-p><C-r> :Rst<CR>
