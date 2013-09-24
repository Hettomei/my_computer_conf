set nocompatible               " be iMproved
filetype off                   " required!

let mapleader = ","

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'pangloss/vim-javascript'
Bundle 'scrooloose/nerdtree'
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-markdown'
Bundle 'godlygeek/tabular'
Bundle 'kchmck/vim-coffee-script'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'scrooloose/nerdcommenter'
Bundle 'ervandew/supertab'
Bundle 'jeetsukumaran/vim-buffergator'
Bundle 'gudleik/vim-slim'
Bundle 'tpope/gem-ctags'
Bundle 'mileszs/ack.vim'
Bundle 'tsaleh/vim-matchit'

syntax on
set autoread " Automatically reload changes if detected
set encoding=utf8
set history=1000

" Tab completion
set wildmode=list:longest,list:full

function s:setupWrapping()
  set wrap
  set textwidth=0
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Guardfile} set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} call s:setupWrapping()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

autocmd BufRead,BufNewFile *.scss,*.less setlocal foldmethod=marker foldmarker={,}
autocmd BufRead,BufNewFile *.coffee setlocal foldmethod=indent

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Enable syntastic syntax checking
let g:syntastic_enable_signs=1
let g:syntastic_quiet_warnings=1

" Turn off jslint errors by default
let g:JSLintHighlightErrorLine = 0

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

let g:Powerline_symbols = 'fancy'

let Tlist_Auto_Update = 'true'

command Vimrc tabnew $MYVIMRC

" fast terminal for smoother redrawing
set ttyfast
