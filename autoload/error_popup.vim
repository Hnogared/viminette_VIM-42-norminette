" File              : error_popup.vim
" Author            : Hnogared <133124217+Hnogared@users.noreply.github.com>
" Date              : 14.01.2024
" Last Modified Date: 14.01.2024
" Last Modified By  : Hnogared <133124217+Hnogared@users.noreply.github.com>

" Function to update the error popup if the cursor is at the same line of one
"  of the placed error signs stored inside 'b:placed_signs_ids'
" Hide the error popup if 'b:normstatus' is not equal to 2 or no signs are
" placed
"
" Called at the 'CursorMoved,CursorMovedI' events (see ../plugin/autocmds.vim)
function! error_popup#update() abort
	if b:normstatus != 2 || b:placed_signs_ids == []
		call popup_hide(b:error_popup_id)
		return
	endif
	for l:sign_id in b:placed_signs_ids
		let l:sign_data = get(b:placed_signs_data, l:sign_id, ['-1', '-1', 'ERR'])
		if line('.') != l:sign_data[0]
			call popup_hide(b:error_popup_id)
			continue
		endif
		call s:setErrorPopupNewData(l:sign_data)
		break
	endfor
endfunction

" Function to set the error popup data and move it according to the argument
"  'a:err_data' and set it to visible
" The start of the popup text ('l:popup_text') contains a visual display of
"  where the error is located horizontally in regards to the cursor
"
" Called by the function 'error_popup#updateErrorPopup()'
function! s:setErrorPopupNewData(err_data) abort
	let l:col_diff = virtcol('.') - a:err_data[1]
	if l:col_diff > 0
		let l:popup_text = '<<'.l:col_diff.' | '.a:err_data[2]
	endif
	if l:col_diff < 0
		let l:col_diff = l:col_diff * -1
		let l:popup_text = l:col_diff.'>> | '.a:err_data[2]
	endif
	if l:col_diff == 0
		let l:popup_text = '<0> | '.a:err_data[2]
	endif
	call popup_move(b:error_popup_id, #{line: 'cursor-1', col: 'cursor-1',})
	call popup_settext(b:error_popup_id, l:popup_text)
	call popup_show(b:error_popup_id)
endfunction
