" File              : norm_error_menu.vim
" Author            : Hnogared <133124217+Hnogared@users.noreply.github.com>
" Date              : 14.01.2024
" Last Modified Date: 14.01.2024
" Last Modified By  : Hnogared <133124217+Hnogared@users.noreply.github.com>

" Function to interpret the error popup menu result and jump to the chosen
" error line.
"
" Called by the function 'norm_error_menu#display()'
function! HandleChoice(id, result) abort
	let l:error_sign_id = b:placed_signs_ids[a:result - 1]
	call sign_jump(l:error_sign_id, g:sign_group_name, bufname())
endfunction

" Function to display a popup menu that asks the user to which error line they
" want to jump to.
" The popup won't show up if 'b:normstatus' is not equal to 2 or the file
"  doesn't contain any norm errors.
"
" Called by the ':NormErrorMenu' command
function! norm_error_menu#display() abort
	if b:normstatus != 2 || b:placed_signs_ids == []
		return
	endif
	let l:errors_list = []
	for l:sign_id in b:placed_signs_ids
		let l:error = get(b:placed_signs_data, l:sign_id, ['-1', '-1', 'ERR'])
		let l:errors_list += ['['.l:error[0].':'.l:error[1].'] '.l:error[2]]
	endfor
	call popup_menu(l:errors_list, #{
			\ line: 'cursor+1',
			\ col: 'cursor',
			\ title: '[ Error line selection ]',
			\ callback: 'HandleChoice',
			\ highlight: 'PopupMenu',
			\ })
endfunction
