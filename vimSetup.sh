#!/bin/bash

## Make neccesary directories
mkdir ~/.vim
mkdir ~/.vim/pack
mkdir ~/.vim/colors
mkdir ~/.vim/pack/plugins
mkdir ~/.vim/pack/plugins/start

## Clone Plugin from GitHub
git clone --branch release https://github.com/neoclide/coc.nvim.git ~/.vim/pack/plugins/start/coc.nvim
git clone https://github.com/alvan/vim-closetag.git ~/.vim/pack/plugins/start/vim-closetag.vim
git clone https://github.com/othree/html5.vim.git ~/.vim/pack/plugins/start/html5.vim
git clone https://github.com/Townk/vim-autoclose.git ~/.vim/pack/plugins/start/vim-autoclose.vim
git clone https://github.com/HerringtonDarkholme/yats.vim.git ~/.vim/pack/plugins/start/yats.vim

## clone colour schemes from GitHub
git clone --recursive https://github.com/noah/vim256-color.git ~/.vim/colors/
