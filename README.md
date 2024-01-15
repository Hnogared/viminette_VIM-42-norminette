# Viminette - VIM builtin 42 norminette ✅❎
A vim plugin for builtin 42 norm error highlighting.<br>
No need to switch away from VIM to check your file norm anymore !

![viminette_screenshot](./srcs/viminette_screensh.png)

![viminette_menu_screenshot](./srcs/viminette_menu_screensh.png)

# Installation

### Norminette
The plugin runs the 42 norminette executable installed on your system.<br>
If you don't have it installed yet, get it at [42 official norminette], else it just won't work.

### Plugins manager
You will also need a VIM plugin manager.<br>
I personnally use [vim-plug], you can install it following their instructions.

### Viminette plugin
Clone the viminette repository in your file system...
```
git clone git@github.com:Hnogared/viminette_VIM-42-norminette.git
```
...and plug it in your *.vimrc* file in your home repository (create it if needed)
```vim
[...]
call plug#begin()

Plug '<path_to_viminette_directory>'

call plug#end()
[...]
```

You are now good to go ! :+1:


# Usage

> [!TIP]
> For more detailed informations on how to use the plugin functionalities, you can run `:help viminette` in your VIM editor to open the documentation.

## 1. Key maps

### Enabling/disabling norm highlighting
`<CTRL-m>` switch ON/OFF norm highlighting

### Jumping between norm error lines
`<CTRL-n>` jump to the closest norm error line after the cursor line.

`<CTRL-b>` jump to the closest norm error line before the cursor line.

### Opening the error lines popup menu
`<CTRL-k>` open a popup menu at the center of the window for the user to select an error line to jump to.

## 2. Commands

### Enabling norm highlighting
```
:Norminette
```
Turn on norm highlighting if the shell norminette command call was successfull.<br>
The highlighting now refreshes after each file save (VIM's `BufWritePost` event) until turned off or an error occurs.

---
```
:Norminette -RCheckDefine
```
Turn on norm highlighting with the -RCheckDefine flag.<br>

### Disabling norm highlighting
```
:NoNorminette
```
Turn off norm highlighting if it was initially turned on.<br>
The highlighting is hidden and doesn't refresh anymore after each file save until turned on again.

### Opening the error lines popup menu
> [!IMPORTANT]
> This command only does something if norm error lines are currently displayed in the file.

```
:NormErrorMenu
```
Open a popup menu at the center of the window for the user to select an error line to jump to.

### Jumping between norm error lines
> [!IMPORTANT]
> These commands only do something if norm error lines are currently displayed in the file.

```
:NextSign
```
Jump to the closest error line in the file after the cursor line. Jump to the first one if none is present after the cursor.

---
```
:PrevSign
```
Jump to the closest error line before the cursor line. Jump to the last one if none is present before the cursor.

---
```
:NextSignCycle
```
Cycle through the error lines from top to bottom. Jump back to the first one from the last one.

---
```
:PrevSignCycle
```
Cycle through the error lines from bottom to top. Jump back to the last one from the first one

# Status line

The plugin's status can be displayed on the status bar.<br>
The `viminette#getNormStatus()` function call returns the status of the norm highlighting.<br>

- 0 = norm highlighting is turned OFF
- 1 = norm highlighting is turned ON and there are no norm errors in the file
- 2 = norm highlighting is turned ON and there are norm errors in the file

This status can be used to update VIM's status line depending on the norm status on your *.vimrc* file :
```vim
" Example on how to implement different colored indicators in the status line depending on the norm status
[...]
hi NormOff ctermbg=234 guibg=#616161
hi NormOn ctermbg=40 guibg=#00FF00
hi NormError ctermbg=196 guibg=#FF0000

set statusline = ...
set statusline += %{%viminette#getNormStatus()==0?'%#NormOff# ':''%}
set statusline += %{%viminette#getNormStatus()==1?'%#NormOn# ':''%}
set statusline += %{%viminette#getNormStatus()==2?'%#NormError# ':''%}
set statusline += ...
[...]
```

```vim
" Example on how to implement different colored indicators in the status line depending on the norm status
" with a function
" This won't work on older versions
[...]
hi NormOff ctermbg=234 guibg=#616161
hi NormOn ctermbg=40 guibg=#00FF00
hi NormError ctermbg=196 guibg=#FF0000

function! MyStatusLine() abort
  let res = ...
  let res .= '%{%viminette#getNormStatus()==0?"%#NormOff# ":""%}'
  let res .= '%{%viminette#getNormStatus()==1?"%#NormOn# ":""%}'
  let res .= '%{%viminette#getNormStatus()==2?"%#NormError# ":""%}'
  let res .= ...
  return res
endfunction

set statusline=%!MyStatusLine()
[...]
```
 
![norm status line](./srcs/norm_status_line.gif)
<sup>What an implementation from above could look like on a VIM status line (the colored rectangle shows the norm status the other stuff is only for display purposes)</sup>

# Special thanks

Thank you [Leizar06001](https://github.com/Leizar06001) for the name idea. Go check out their cool projects !

[42 official norminette]:https://github.com/42School/norminette
[vim-plug]:https://github.com/junegunn/vim-plug
