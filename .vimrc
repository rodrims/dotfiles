set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

color slate
set number
set nobackup
set nowritebackup
set tabstop=4
set shiftwidth=4
set softtabstop=4
set textwidth=80

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '""' . arg1 . '""' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '""' . arg2 . '""' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '""' . arg3 . '""' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '""'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff"'
  endif
  silentexecute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction
