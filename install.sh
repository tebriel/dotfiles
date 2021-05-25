#!/usr/bin/env bash
# This script sets up our codespaces environment

set -euo pipefail

function copy_dotfiles() {
    # Copy our dotfiles
    gem install homesick

    homesick clone tebriel/dotfiles

    homesick link dotfiles
}

function install_starship() {
    curl -o starship-install.sh -fsSL https://starship.rs/install.sh
    bash starship-install.sh -y
}

function install_homebrew() {
    NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # shellcheck disable=SC2016
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /root/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    brew install gcc asdf direnv rbenv zoxide ctags task vim gcc@5 cmake
}

function configure_asdf() {
    asdf plugin-add direnv
    asdf install direnv latest
    asdf global direnv latest
}

function configure_vim() {
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim +PluginInstall +qall

    # youcompleteme
    apt install -y build-essential python3-dev
    apt install -y mono-complete golang nodejs default-jdk npm
    pushd ~/.vim/bundle/YouCompleteMe
    python3 install.py --all
}

# Set zsh as our default shell
chsh -s /bin/zsh

copy_dotfiles
install_starship
install_homebrew
configure_asdf
configure_vim
