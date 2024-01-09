" Function to enable the norm errors highlighting on the current buffer
" The optional argument for the norminette shell command is stored inside the
"  'b:norm_option' variablle
" The function for norm error highlighting refreshing is called once
"
" Called by the ':Norminette [option]' command (see ../plugin/commands.vim)
function! viminette#highlightEnable(...) abort
	let b:norm_status = 1
	if a:0 == 0
		let b:norm_option = ''
	else
		let b:norm_option = a:1
	endif
	call viminette#highlightRefresh()
endfunction

" Function to refresh the norm errors highlighting on the current buffer
" The norminette shell command is run and its result is parsed to place all
"  the error signs and store their associated errors' data, if need be
" An error is echoed instead if the file is invalid for the norm (not a C
"  source/header file), a '<filepath> OK' message is echoed if the file is
"  normed
" The error popup is refreshed to the new highlight
"
" Called at the 'TextChanged' event (see ../plugin/autocmds.vim)
function! viminette#highlightRefresh() abort
	if b:norm_status == 0
		return
	endif
	call cleanup#unplaceSigns()
	let l:filename = expand('%')
	let l:norm_res = s:RunNorminette(l:filename, b:norm_option)
	let l:sign_id = 1
	for l:line in l:norm_res
		let l:err_line = matchstr(l:line, '\m\c^Error.*line:\s\+\zs\d\+')
		if l:err_line == ''
			continue
		endif
		let l:err_col = matchstr(l:line, '\m\c^Error.*col:\s\+\zs\d\+')
		let l:err_msg = matchstr(l:line, '\m\c):\s\+\zs.*$')
		call s:PlaceErrorSign(l:sign_id, l:filename, [
			\ l:err_line,
			\ l:err_col,
			\ l:err_msg,
			\ ])
		let l:sign_id += 1
	endfor
	call error_popup#updateErrorPopup()
endfunction

" Function to disable the norm errors highlighting on the current buffer
" All placed norm error signs are unplaced and the error popup is hidden if
"  visible
"
" Called by the ':NoNorminette' command (see ../plugin/commands.vim)
function! viminette#highlightDisable() abort
	if b:norm_status == 0
		return
	endif
	call cleanup#unplaceSigns()
	call popup_hide(b:error_popup_id)
	let b:norm_status = 0
endfunction

" Function to get the current buffer norm status.
" 0 = norm highlighting is disabled
" 1 = norm highlighting is enabled with norm errors
" 2 = norm highlighting is enabled without norm errors
function! viminette#getNormStatus() abort
	return b:norm_status
endfunction

" Function to run the norminette shell command and check its result
" If the command succeeded and the result's first line doesn't contain the
"  'Error' word, echo a '<filepath> OK' message and return an empty list
" If the command succeeded and the result's first line contains the 'Error'
"  word, return the list of all lines returned by the norminette command
" If the command failed, echo the result's first line (the error message) and
"  return an empty list
"
" Called by the function 'norvimette#highlightEnable()'
function! s:RunNorminette(filename, options) abort
	let l:norm_res = systemlist('norminette '.a:options.' '.a:filename)
	if v:shell_error == 0 && stridx(l:norm_res[0], 'Error') == -1
		if b:norm_status == 1
			return []
		endif
		echohl OkMsg
		echomsg l:norm_res[0]
		echohl None
		let b:norm_status = 1
		return []
	endif
	if len(l:norm_res) == 1
		echohl WarningMsg
		echomsg l:norm_res[0]
		echohl None
		let b:norm_status = 0
		return []
	endif
	let b:norm_status = 2
	return l:norm_res
endfunction

" Function to place an error sign according to its parameters
" The sign's name (its type) is chosen from the 'g:signs_keys' list (see
"  ../plugin/norvimette.vim) and depends on the content of the error message
"  inside the argument 'a:error_data' (a:error_data[2])
" The first keyword match with the 'g:signs_keys' list is used for the sign name
" If no match is found, the default name is used (g:signs_keys[0])
"
" Called by the function 'norvimette#highlightEnable()'
function! s:PlaceErrorSign(id, filename, error_data) abort
	let l:sign_name = g:signs_keys[0]
	for l:key in g:signs_keys
		if matchstr(a:error_data[2], '\m\c'.l:key) != ''
			let l:sign_name = l:key
			break
		endif
	endfor
	let l:sign_place_cmd = 'sign place '.a:id.' line='.a:error_data[0]
	let l:sign_place_cmd = l:sign_place_cmd.' name='.l:sign_name
	execute l:sign_place_cmd.' group='.g:sign_group_name.' file='.a:filename
	let b:placed_signs_ids += [a:id]
	let b:placed_signs_data[a:id] = a:error_data
endfunction
