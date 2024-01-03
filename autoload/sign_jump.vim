" Function to jump to the sign id preceeding the one stored inside
"  'b:curr_cycle_jump_id'
" The variable 'b:curr_cycle_jump_id' is decremented at each jump, if it
"  reaches -1, it is reset to the last sign id
function! sign_jump#prevSignCycleJump() abort
	if b:placed_signs_ids == []
		return
	endif
	let b:curr_cycle_jump_id -= 1
	if b:curr_cycle_jump_id < 1
		let b:curr_cycle_jump_id = len(b:placed_signs_ids)
	endif
	execute 'sign jump '.b:curr_cycle_jump_id.' group='.g:sign_group_name
endfunction

" Function to jump to the sign id following the one stored inside
"  'b:curr_cycle_jump_id'
" The variable 'b:curr_cycle_jump_id' is incremented at each jump, if it
"  reaches more than the signs count, it is reset to the first sign id
function! sign_jump#nextSignCycleJump() abort
	if b:placed_signs_ids == []
		return
	endif
	let b:curr_cycle_jump_id += 1
	if b:curr_cycle_jump_id > len(b:placed_signs_ids)
		let b:curr_cycle_jump_id = 1
	endif
	execute 'sign jump '.b:curr_cycle_jump_id.' group='.g:sign_group_name
endfunction
