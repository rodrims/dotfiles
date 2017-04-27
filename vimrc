set background=dark
set cindent
set cinkeys-=0#
set hlsearch
set incsearch
set indentkeys-=0#
set listchars=tab:»\ ,eol:¬,nbsp:·,trail:·
set nobackup
set nolist
set noundofile
set nowritebackup
set number
set relativenumber
set shiftwidth=4
set showbreak=+++
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set timeoutlen=3000
set ttimeoutlen=100

syntax enable

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
