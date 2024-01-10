" Avoid loading the plugin more than once
" The function exists('x') only returns true if the variable x has already been
"  declared and initialized.
if exists('g:loaded_norvimette')
	finish
endif
let g:loaded_norvimette = 1

" The group name containing all the norm error signs
let g:sign_group_name = 'NormError'

" Dictionary storing all the used signs and their attributes
" The first key is used if no error corresponding to the other ones is found
let g:signs_dict = #{
		\ Error: ['text=>>', 'texthl=ErrorSign', 'linehl=ErrorSignLine'],
		\ Space: ['text=s>', 'texthl=ErrorSign', 'linehl=ErrorSignLine'],
		\ Variable: ['text=v>', 'texthl=ErrorSign', 'linehl=ErrorSignLine'],
		\ Line: ['text=l>', 'texthl=ErrorSign', 'linehl=ErrorSignLine'],
		\ Comment: ['text=c>', 'texthl=ErrorSign', 'linehl=ErrorSignLine'],
\}

" List of all the keys of the 'g:signs_dict' dictionary for iterating over it
let g:signs_keys = keys(g:signs_dict)
