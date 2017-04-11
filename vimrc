set autoindent
set background=dark
set hlsearch
set nobackup
set noundofile
set nowritebackup
set number
set relativenumber
set shiftwidth=4
set smartindent
set softtabstop=4
set splitbelow " new windows are split bottomwise
set splitright " new windows are split rightwise
set tabstop=4

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

:nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>
noremap <C-y> :call HighlightToggle()<cr>
noremap <C-n> :call NumberToggle()<cr>
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>
