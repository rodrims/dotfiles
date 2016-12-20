set nobackup
set nowritebackup
set number
set noundofile
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=80

" This I didn't write, but I understand.
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

autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber
