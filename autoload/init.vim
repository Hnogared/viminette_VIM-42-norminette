" File              : init.vim
" Author            : Hnogared <133124217+Hnogared@users.noreply.github.com>
" Date              : 14.01.2024
" Last Modified Date: 14.01.2024
" Last Modified By  : Hnogared <133124217+Hnogared@users.noreply.github.com>

" Function to declare and initialize the buffer local variables
"
" Called at the 'Filetype,BufEnter,BufNew,BufReadPre' events
"  (see ../plugin/autocmds.vim)
function! init#declareBufferVariables() abort
	if !exists('b:norm_status')
		let b:norm_status = 0
	endif
	if !exists('b:norm_option')
		let b:norm_option = ''
	endif
	if !exists('b:placed_signs_ids')
		let b:placed_signs_ids = []
	endif
	if !exists('b:placed_signs_ids')
		let b:placed_signs_ids = []
	endif
	if !exists('b:placed_signs_data')
		let b:placed_signs_data = {}
	endif
	if !exists('b:curr_cycle_jump_id')
		let b:curr_cycle_jump_id = 1
	endif
	if !exists('b:error_popup_id')
		let b:error_popup_id = popup_create("EMPTY", #{
				\ pos: 'botleft',
				\ highlight: 'NormErrorPopup',
				\ padding: [0, 1, 0, 1],
				\ wrap: 'FALSE',
				\ })
		call popup_hide(b:error_popup_id)
	endif
endfunction

" Function to define all the needed signs prototyped inside the dictionary
"  'g:signs_dict' (see ../plugin/norvimette.vim)
"
" Called at the 'VimEnter' event (see ../plugin/autocmds.vim)
function! init#defineSigns() abort
	for l:item in g:signs_keys
		let l:sign_args = get(g:signs_dict, l:item, ["text=>>", "", ""])
		let l:command = "sign define ".l:item." ".l:sign_args[0]
		let l:command = l:command." ".l:sign_args[1]." ".l:sign_args[2]
		execute l:command
	endfor
endfunction
