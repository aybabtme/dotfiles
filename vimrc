set nocompatible
set number
execute pathogen#infect()
syntax on

filetype plugin on
filetype on
filetype indent on
filetype off

filetype plugin indent off
set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on

set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set rtp+=$GOPATH/src/github.com/gocode/vim

" Go stuff
function! s:GoVet()
	cexpr system("go vet " . shellescape(expand('%')))
	copen
endfunction
command! GoVet :call s:GoVet()

autocmd BufWritePre *.go Fmt
autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
autocmd BufWritePost,FileWritePost *.go execute 'GoVet' | cwindow
autocmd FileType go compiler go


" Recognize markdown files
au BufRead,BufNewFile *.md set filetype=markdown

" NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q
map <F2> :NERDTreeToggle<CR>
