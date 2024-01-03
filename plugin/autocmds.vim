augroup norvimette
	" Reset the 'norvimette' augroup autocmds
	autocmd!
	
	" Define the signs used to show norm errors
	autocmd VimEnter * call init#defineSigns()

	" Declare the buffer local variables if needed on new buffer interactions
	autocmd Filetype,BufEnter,BufNew,BufReadPre * call init#declareBufferVariables()

	" Check if the cursor moved on a norm error line to display the error popup
	autocmd CursorMoved,CursorMovedI * call error_popup#updateErrorPopup()

	" Hide a buffer's error popup if it is not shown on a window anymore
	autocmd BufWinLeave * call popup_hide(b:error_popup_id) 
augroup END
