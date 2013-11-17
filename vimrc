set number
set nocompatible
syntax on

filetype plugin on
filetype on
filetype indent on

set rtp+=$GOROOT/misc/vim
set rtp+=$GOPATH/src/github.com/golang/lint/misc/vim
set rtp+=$GOPATH/src/github.com/gocode/vim

autocmd BufWritePost,FileWritePost *.go execute 'Lint' | cwindow
autocmd BufWritePre *.go Fmt
