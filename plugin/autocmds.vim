" File              : autocmds.vim
" Author            : Hnogared <133124217+Hnogared@users.noreply.github.com>
" Date              : 14.01.2024
" Last Modified Date: 14.01.2024
" Last Modified By  : Hnogared <133124217+Hnogared@users.noreply.github.com>

augroup norvimette
	" Reset the 'norvimette' augroup autocmds
	autocmd!
	
	" Define the signs used to show norm errors
	autocmd VimEnter * call init#defineSigns()

	" Declare the buffer local variables if needed on new buffer interactions
	autocmd Filetype,BufEnter,BufNew,BufReadPre * call init#declareBufferVariables()

	" Refresh the norm error highlighting after each save
	autocmd BufWritePost * call viminette#highlightRefresh()

	" Check if the cursor moved on a norm error line to display the error popup
	autocmd CursorMoved,CursorMovedI * call error_popup#update()

	" Hide a buffer's error popup if it is not shown on a window anymore
	autocmd BufWinLeave * call popup_hide(b:error_popup_id) 
augroup END
