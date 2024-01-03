" Function to undefine all the signs prototyped inside the dictionary
"  'g:signs_dict' (see ../plugin/norvimette.vim)
function! cleanup#undefineSigns() abort
	for l:item in g:signs_keys
		execute 'sign undefine '.l:item
	endfor
endfunction

" Function to unplace all the buffer local signs using their ids inside
"  'b:placed_signs_ids'
" Reset the placed signs ids and data (error message and position) and the
"  variable 'b:curr_jump_id' used to jump between norm error signs
"
" Called at the start of the ':Norminette [option]' command to refresh the
"  signs and by the ':NoNorminette' command (see norvimette.vim)
function! cleanup#unplaceSigns() abort
	let l:filename = expand('%')
	for l:sign_id in b:placed_signs_ids
		let l:unplace_cmd = 'sign unplace '.l:sign_id
		execute l:unplace_cmd.' group='.g:sign_group_name.' file='.l:filename
	endfor
	let b:placed_signs_ids = []
	let b:placed_signs_data = {}
	let b:curr_jump_id = 1
endfunction
