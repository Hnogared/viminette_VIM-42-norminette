" NORM ERRORS HIGHLIGHT "

" If the file has no norm error, echo a '<filepath> OK' message 
" Else if the file is valid for the norm, place all norm error associated
"  signs and enable the norm error popup on the current buffer
" If the file is invalid for the norm (not a C source/header file), display an
"  error
"
" One optional argument allowing to run ':Norminette -RCheckDefine'
command -nargs=? Norminette call viminette#highlightEnable(<f-args>)

" Unplaces all the placed norm error signs and disables the norm error popup
"  on the current buffer
command -nargs=0 NoNorminette call viminette#highlightDisable()


" SIGNS JUMPS "

" Jump to the closest error sign placed before the cursor line
" Jump from the first sign to the last one
command -nargs=0 PrevSign call sign_jump#prevSignJump()

" Jump to the closest error sign placed after the cursor line
" Jump from the last sign to the first one
command -nargs=0 NextSign call sign_jump#nextSignJump()

" Jump to the placed error sign id before the one stored inside
"  'b:curr_cycle_jump_id' and decrement 'b:curr_cycle_jump_id'
" Jump from the first sign to the last one
command -nargs=0 PrevSignCycle call sign_jump#prevSignCycleJump()

" Jump to the placed error sign id after the one stored inside
"  'b:curr_cycle_jump_id' and increment 'b:curr_cycle_jump_id'
" Jump from the last sign to the first one
command -nargs=0 NextSignCycle call sign_jump#nextSignCycleJump()
