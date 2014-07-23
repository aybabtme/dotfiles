function gb
    git branch
end

function gco
    git checkout
end

function gl
    git log --graph --decorate --pretty=oneline --abbrev-commit --color='Always'
end

function gla
    git log --graph --decorate --pretty=oneline --abbrev-commit --all
end

function gs
    git status
end


function ll
    ls -Glh
end

function la
    ls -Glah
end

function ls
    la
end


function tailf
    tail -f
end
