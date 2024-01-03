" Usage :Norminette [option]
"
" If the file has no norm error, echo a '<filepath> OK' message 
" Else if the file is valid for the norm, place all norm error associated
"  signs and enable the norm error popup on the current buffer
" If the file is invalid for the norm (not a C source/header file), display an
"  error
"
" [option] is an optional argument allowing to run ':Norminette -RCheckDefine'
command -nargs=? Norminette call norvimette#highlightEnable(<f-args>)

" Usage :NoNorminette
"
" Unplaces all the placed norm error signs and disables the norm error popup
"  on the current buffer
command -nargs=0 NoNorminette call norvimette#highlightDisable()
