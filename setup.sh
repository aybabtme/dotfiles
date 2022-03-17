#!/usr/bin/env bash

root=$(git rev-parse --show-toplevel)

set -Eeuox pipefail

function require_command() {
    local cmd=${1}
    if ! command -v ${cmd} &> /dev/null; then
        echo "${cmd} could not be found"
        exit
    fi
}

function setup_dotfiles_symlink() {
    require_command "ln"

    mkdir -p "${HOME}/.config/"
    overwrite_with_symlink "${root}/config/fish" "${HOME}/.config/fish"
    overwrite_with_symlink "${root}/gitconfig" "${HOME}/.gitconfig"
    overwrite_with_symlink "${root}/gitignore" "${HOME}/.gitignore"
    overwrite_with_symlink "${root}/" "${HOME}/dotfiles"
}

function overwrite_with_symlink() {
    require_command "ln"
    require_command "unlink"

    local src=${1}
    local dst=${2}
    if [ -L ${dst} ]; then
        unlink ${dst}
    elif [ -f ${dst} ]; then
        rm ${dst}
    fi
    ln -s ${src} ${dst}
}

function change_shell_to_fish() {
    require_command "which"
    require_command "fish"
    require_command "sudo"
    require_command "chsh"

    local fish_path=$(which fish)
    if grep -q "fish" /etc/shells; then
        sudo echo ${fish_path} >> /etc/shells
    fi
    chsh -s ${fish_path}
}

function main() {
    setup_dotfiles_symlink
    change_shell_to_fish
}

main