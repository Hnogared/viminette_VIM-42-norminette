" Normal mode map <CTRL-m> to switch ON/OFF norm highlighting.
nmap <expr> <C-m> viminette#getNormStatus()==0 ? ':Norminette<CR>' : ':NoNorminette<CR>'

" Normal mode map <CTRL-n> to jump to the next error line.
nmap <C-n> :NextSign<CR>

" Normal mode map <CTRL-b> to jump to the previous error line.
nmap <C-b> :PrevSign<CR>

" Normal mode map <CTRL-k> to display the error lines jump menu.
nmap <C-k> :NormErrorMenu<CR>
