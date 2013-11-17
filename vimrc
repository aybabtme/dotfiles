set number
set nocompatible
syntax on

filetype plugin on
filetype on
filetype indent on

set rtp+=$GOROOT/misc/vim
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


" Recognize markdown files
au BufRead,BufNewFile *.md set filetype=markdown


" Tabs instead oc <c-x> <c-o>
autocmd FileType *
    \ if &omnifunc != '' |
    \   call SuperTabChain(&omnifunc, "<c-p>") |
    \   call SuperTabSetDefaultCompletionType("<c-x><c-u>") |
    \ endif
