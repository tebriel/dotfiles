{ config, pkgs, ... }:

let
  powerlevel10k = pkgs.fetchFromGitHub {
    owner = "romkatv";
    repo = "powerlevel10k";
    rev = "v1.15.0";
    sha256 = "1b3j2riainx3zz4irww72z0pb8l8ymnh1903zpsy5wmjgb0wkcwq";
  };

  ag-vim = pkgs.vimUtils.buildVimPlugin {
    name = "ag.vim";
    src = pkgs.fetchFromGitHub {
      owner = "rking";
      repo = "ag.vim";
      rev = "4a0dd6e190f446e5a016b44fdaa2feafc582918e";
      sha256 = "1b3j2riainx3zz4irww72z0pb8l8ymnh1903zpsy5wmjgb0wkcwq";
    };
  };

  vim-rake = pkgs.vimUtils.buildVimPlugin {
    name = "vim-rake";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-rake";
      rev = "v2.0";
      sha256 = "1b3j2riainx3zz4irww72z0pb8l8ymnh1903zpsy5wmjgb0wkcwq";
    };
  };

  vim-bundler = pkgs.vimUtils.buildVimPlugin {
    name = "vim-bundler";
    src = pkgs.fetchFromGitHub {
      owner = "tpope";
      repo = "vim-bundler";
      rev = "v2.1";
      sha256 = "1b3j2riainx3zz4irww72z0pb8l8ymnh1903zpsy5wmjgb0wkcwq";
    };
  };

in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    EDITOR = "vim";
    SSH_AUTH_SOCK = "/Users/tebriel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
    FZF_CTRL_T_COMMAND = "$FZF_DEFAULT_COMMAND";
  };

  home.sessionPath = [
    # ASDF schenanigans
    "~/.asdf/bin"
    # Node Pathing
    "~/.yarn/bin"
    "~/.config/yarn/global/node_modules/.bin"
    # Python Pathing
    "~/.local/bin"
    # Homewbrew Pathing
    "/usr/local/bin"
    "/usr/local/sbin"
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "tebriel";
  home.homeDirectory = "/Users/tebriel";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = [
    pkgs.direnv
    pkgs.dotnet-sdk_5
    pkgs.fd
    pkgs.gh
    pkgs.git
    pkgs.irssi
    pkgs.rbenv
    pkgs.screen
    pkgs.shellcheck
    pkgs.silver-searcher
    pkgs.sl
    pkgs.taskwarrior
    pkgs.tree
    pkgs.unzip
    pkgs.zoxide
    pkgs.zsh
  ];

  home.file.".screenrc".source = ../screen/screenrc;
  home.file.".taskrc".source = ../taskwarrior/taskrc;

  programs.bat = {
    enable = true;
    config = {
      theme = "ansi";
    };
  };

  programs.fzf = {
    enable = true;
    fileWidgetCommand = "fd --type f --hidden --follow --exclude .git";
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    defaultOptions = [ "--border" "--info=inline" ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    envExtra = builtins.readFile ../zsh/env.zsh;
    initExtraFirst = builtins.readFile ../zsh/initExtraFirst.zsh;
    initExtra = builtins.readFile ../zsh/init.zsh + builtins.readFile ../zsh/p10k.zsh;
    initExtraBeforeCompInit = builtins.readFile ../zsh/initExtraBeforeCompInit.zsh;
    # defaultKeymap = "vicmd";
    plugins = [{
      name = "powerlevel10k";
      src = powerlevel10k;
      file = "powerlevel10k.zsh-theme";
    }];
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    withRuby = true;
    extraConfig = builtins.readFile ../vim/vimrc;
    plugins = with pkgs.vimPlugins; [
      # General Utility
      direnv-vim
      {
        plugin = vim-commentary;
        config = ''
nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary'';
      }
      vim-git
      vim-fugitive
      # ciaranm/securemodelines
      {
        plugin = ag-vim;
      }
      # farseer90718/vim-taskwarrior
      {
        plugin = fzf-vim;
        config = "nmap <C-P> :FZF<CR>";
      }
      # Figure out tabs
      sleuth

      # Visual Stuff
      {
        plugin = vim-airline;
        config = ''
let g:airline_powerline_fonts=1
let g:airline_section_c='%t'
let g:airline#extensions#ale#enabled = 1
        '';
      }

      dracula-vim

      # Language Tools
      {
        plugin = vim-go;
        config = ''
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
        '';
      }
      {
        plugin = ale;
        config = "let g:ale_linters = { 'ruby': ['rubocop'], }";
      }
      YouCompleteMe

      # Ruby Stuff
      vim-rails
      {
        plugin = vim-rake;
      }
      {
        plugin = vim-bundler;
      }
      vim-dispatch

      # Language Syntax
      vim-yaml
      vim-markdown
      typescript-vim
      rust-vim
      vim-ruby
      vim-hcl

      {
        plugin = vim-test;
        config = ''
nmap <silent> t<C-n> :TestNearest<CR>
nmap <silent> t<C-f> :TestFile<CR>
nmap <silent> t<C-s> :TestSuite<CR>
nmap <silent> t<C-l> :TestLast<CR>
nmap <silent> t<C-g> :TestVisit<CR>
let test#strategy = "dispatch"
        '';
      }

      vim-nix
    ];
  };
}
