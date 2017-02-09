set background=dark
set nobackup
set noundofile
set nowritebackup
set number
set relativenumber
set shiftwidth=4
set smartindent
set softtabstop=4
set tabstop=4

colorscheme solarized
syntax enable

function! NumberToggle()
	if (&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

noremap <C-n> :call NumberToggle()<cr>

:au FocusLost * :set norelativenumber
:au FocusGained * :set relativenumber
