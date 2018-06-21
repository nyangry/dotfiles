" [Vim documentation: nvim](https://neovim.io/doc/user/nvim.html#nvim-from-vim)
set runtimepath+=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

let g:python2_host_prog=$PYENV_ROOT.'/versions/neovim2/bin/python'
let g:python3_host_prog=$PYENV_ROOT.'/versions/neovim3/bin/python'

source ~/.vimrc
