set background=dark
set clipboard=unnamedplus " use system clipboard as default register
set cursorline " highlight the current line
set expandtab " make tab characters into spaces
set hlsearch " hightlight search results when using /
set ignorecase " search becomes case-insensitive
set incsearch " highlight search results as you type
set lazyredraw " makes scrolling less choppy
set listchars=tab:»\ ,eol:¬,nbsp:·,trail:· " chars to represent invisibles
set nobackup " stops creation of vim ~ backup files
set nolist
set noundofile
set nowritebackup
set number " show line numbers
set relativenumber "show relative line numbers (in combo with above line shows current line number and relative on other lines)
set shiftwidth=4
set showbreak=\ \  " character to start a line that is wrapped
set smartcase " if an upper-case character is in a search, the search will be case-sensitive ignoring 'ignorecase'
set smartindent
set softtabstop=4
set splitbelow " sets default behaviour of :new
set splitright " sets default behaviour of :vnew
set tabstop=4
set timeoutlen=3000
set ttimeoutlen=100

let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"

syntax enable " sytax highlighting

" solarized colorscheme fixes
let g:solarized_termcolors=16
set t_Co=16
colorscheme solarized
hi Normal ctermbg=none
hi NonText ctermbg=none

function! HighlightToggle()
	if (&hlsearch == 1)
		set nohlsearch
	else
		set hlsearch
	endif
endfunc

function! ListToggle()
	if (&list == 1)
		set nolist
	else
		set list
	endif
endfunc

function! NumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

inoremap jk <Esc>
inoremap <C-\> <Esc>:call ListToggle()<cr>i
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
noremap <C-Y> :call HighlightToggle()<cr>
noremap <C-\> :call ListToggle()<cr>
noremap <C-N> :call NumberToggle()<cr>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
