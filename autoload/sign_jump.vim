" Function to jump to the closest error sign placed before the cursor line
" No jump execution if 'b:normstatus' is not equal 2 or no signs are placed
" Jump to the last sign of the buffer if no sign is placed before the cursor
"  line and display an error message
"
" Called by the ':PrevSign' command (see ../plugin/commands.vim)
function! sign_jump#prevSignJump() abort
	if b:normstatus != 2 || b:placed_signs_ids == []
		return
	endif
	let l:cursor_line = line('.')
	let l:closest_distance = -1
	let l:closest_sign_id = -1
	for l:sign_id in b:placed_signs_ids
		let l:sign_data = get(b:placed_signs_data, l:sign_id, ['-1', '-1', 'ERR'])
		let l:distance = l:cursor_line - l:sign_data[0]
		if l:distance > 0 && (l:closest_distance == -1
					\ || l:distance < l:closest_distance)
			let l:closest_distance = l:distance
			let l:closest_sign_id = l:sign_id
		endif
	endfor
	if l:closest_distance == -1
		let l:closest_sign_id = l:sign_id
		echohl WarningMsg
		echomsg 'No previous sign, jumping to the last one'
		echohl None
	endif
	call sign_jump(l:closest_sign_id, g:sign_group_name, bufname())
endfunction

" Function to jump to the closest error sign placed after the cursor line
" No jump execution if 'b:normstatus' is not equal 2 or no signs are placed
" Jump to the first sign of the buffer if no sign is placed after the cursor
"  line and display an error message
"
" Called by the ':NextSign' command (see ../plugin/commands.vim)
function! sign_jump#nextSignJump() abort
	if b:normstatus != 2 || b:placed_signs_ids == []
		return
	endif
	let l:cursor_line = line('.')
	let l:closest_distance = -1
	let l:closest_sign_id = -1
	for l:sign_id in b:placed_signs_ids
		let l:sign_data = get(b:placed_signs_data, l:sign_id, ['-1', '-1', 'ERR'])
		let l:distance = l:sign_data[0] - l:cursor_line
		if l:distance > 0 && (l:closest_distance == -1
					\ || l:distance < l:closest_distance)
			let l:closest_distance = l:distance
			let l:closest_sign_id = l:sign_id
		endif
	endfor
	if l:closest_distance == -1
		let l:closest_sign_id = b:placed_signs_ids[0]
		echohl WarningMsg
		echomsg 'No following sign, jumping to the first one'
		echohl None
	endif
	call sign_jump(l:closest_sign_id, g:sign_group_name, bufname())
endfunction

" Function to jump to the sign id before the one inside 'b:curr_cycle_jump_id'
" No jump execution if 'b:normstatus' is not equal 2 or no signs are placed
" Decrement the variable 'b:curr_cycle_jump_id' before each jump, if it
"  reaches -1, reset it to the last sign id and echo an error message
function! sign_jump#prevSignCycleJump() abort
	if b:normstatus != 2 || b:placed_signs_ids == []
		return
	endif
	let b:curr_cycle_jump_id -= 1
	if b:curr_cycle_jump_id < 1
		let b:curr_cycle_jump_id = len(b:placed_signs_ids)
		echohl WarningMsg
		echomsg 'No previous sign, jumping to the last one'
		echohl None
	endif
	call sign_jump(b:curr_cycle_jump_id, g:sign_group_name, bufname())
endfunction

" Function to jump to the sign id after the one inside 'b:curr_cycle_jump_id'
" No jump execution if 'b:normstatus' is not equal 2 or no signs are placed
" Increment the variable 'b:curr_cycle_jump_id' before each jump, if it
"  exceeds the signs count, reset it to the first sign id and echo an error
"  message
function! sign_jump#nextSignCycleJump() abort
	if b:normstatus != 2 || b:placed_signs_ids == []
		return
	endif
	let b:curr_cycle_jump_id += 1
	if b:curr_cycle_jump_id > len(b:placed_signs_ids)
		let b:curr_cycle_jump_id = 1
		echohl WarningMsg
		echomsg 'No following sign, jumping to the first one'
		echohl None
	endif
	call sign_jump(b:curr_cycle_jump_id, g:sign_group_name, bufname())
endfunction
