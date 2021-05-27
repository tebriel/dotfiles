#!/usr/bin/env bash
# This script sets up our codespaces environment

set -euo pipefail

SCRIPT_NAME=${1:-"install.sh"}
# Send all our -x output to this file for later debugging
LOG_DIR="$HOME/install.sh.logs"
mkdir -p "${LOG_DIR}"
exec 1>"${LOG_DIR}/stdout"
exec 2>"${LOG_DIR}/stderr"
exec 19>"${LOG_DIR}/trace"
BASH_XTRACEFD=19

set -x

echo "${SCRIPT_NAME} start: $(date)"

function system_ruby() {
    if ! hash ruby; then
        sudo apt install -y ruby-full
    fi
}

function copy_dotfiles() {
    # Copy our dotfiles
    gem install homesick

    homesick clone tebriel/dotfiles

    homesick link --force dotfiles
}

function install_starship() {
    curl -o starship-install.sh -fsSL https://starship.rs/install.sh
    sudo bash starship-install.sh -y
}

function install_homebrew() {
    NONINTERACTIVE=1 bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    # shellcheck disable=SC2016
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> "${HOME}/.zprofile"
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
    sudo apt install -y build-essential python3-dev
    sudo apt install -y mono-complete golang nodejs default-jdk npm
    pushd ~/.vim/bundle/YouCompleteMe
    python3 install.py --all
}

# Set zsh as our default shell
sudo chsh -s /bin/zsh

system_ruby
copy_dotfiles
install_starship
install_homebrew
configure_asdf
configure_vim

echo "${SCRIPT_NAME} end $(date)"
