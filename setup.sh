#!/usr/bin/env bash

root=$(git rev-parse --show-toplevel)

function require_command() {
    local cmd=${1}
    if ! command -v ${cmd} &> /dev/null; then
        echo "${cmd} could not be found"
        exit
    fi
}

function setup_dotfiles_simlink() {
    require_command "ln"

    ln -s ${root}/config $HOME/.config
    ln -s ${root}/gitconfig $HOME/.gitconfig
    ln -s ${root}/gitignore $HOME/.gitignore
}

function change_shell_to_fish() {
    require_command "which"
    require_command "fish"
    require_command "sudo"
    require_command "echo"
    require_command "chsh"

    local fish_path=$(which fish)
    if grep -q "fish" /etc/shells; then
        sudo echo ${fish_path} >> /etc/shells
    fi
    chsh -s ${fish_path}
}

function main() {
    setup_dotfiles_simlink
    change_shell_to_fish
}

main