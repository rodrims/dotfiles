set background=dark
set cindent
set cinkeys-=0#
set hlsearch " hightlight search results when using /
set incsearch " highlight search results as you type
set indentkeys-=0#
set listchars=tab:»\ ,eol:¬,nbsp:·,trail:· " chars to represent invisibles
set nobackup " stops creation of vim ~ backup files
set nolist
set noundofile
set nowritebackup
set number " show line numbers
set relativenumber "show relative line numbers (in combo with above line shows current line number and relative on other lines)
set shiftwidth=4
set showbreak=+++ " character to start a line that is wrapped
set softtabstop=4
set splitbelow " sets default behaviour of :new
set splitright " sets default behaviour of :vnew
set tabstop=4
set timeoutlen=3000
set ttimeoutlen=100
set clipboard=unnamedplus

syntax enable " sytax highlighting

" solarized colorscheme fixes
let g:solarized_termcolors=16
set t_Co=16
colorscheme solarized

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
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
noremap <C-Y> :call HighlightToggle()<cr>
noremap <C-\> :call ListToggle()<cr>
noremap <C-N> :call NumberToggle()<cr>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
