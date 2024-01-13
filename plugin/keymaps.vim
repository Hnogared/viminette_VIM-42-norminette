" File              : keymaps.vim
" Author            : Hnogared <133124217+Hnogared@users.noreply.github.com>
" Date              : 14.01.2024
" Last Modified Date: 14.01.2024
" Last Modified By  : Hnogared <133124217+Hnogared@users.noreply.github.com>

" Normal mode map <CTRL-m> to switch ON/OFF norm highlighting.
nnoremap <silent> <expr> <C-m> viminette#getNormStatus()==0 ? ':Norminette<CR>' : ':NoNorminette<CR>'

" Normal mode map <CTRL-n> to jump to the next error line.
nnoremap <silent> <C-n> :NextSign<CR>

" Normal mode map <CTRL-b> to jump to the previous error line.
nnoremap <silent> <C-b> :PrevSign<CR>

" Normal mode map <CTRL-k> to display the error lines jump menu.
nnoremap <silent> <C-k> :NormErrorMenu<CR>
