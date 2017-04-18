set background=dark
set cindent
set cinkeys-=0#
set copyindent
set hlsearch
set indentkeys-=0#
set nobackup
set noundofile
set nowritebackup
set number
set relativenumber
set shiftwidth=4
set softtabstop=4
set splitbelow " new windows are split bottomwise
set splitright " new windows are split rightwise
set tabstop=4
set timeoutlen=3000
set ttimeoutlen=100

syntax enable

" solarized colorscheme
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

function! NumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

inoremap jk <Esc>
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
nnoremap <O> <k><C-o>
noremap <C-y> :call HighlightToggle()<cr>
noremap <C-n> :call NumberToggle()<cr>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
