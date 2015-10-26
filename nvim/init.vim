" be iMproved
set nocompatible

" required!
filetype off

" Vundle {
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'godlygeek/tabular' " Make multiple things aligned
Plugin 'scrooloose/syntastic'
Plugin 'gorkunov/smartpairs.vim' " make easy with vv
Plugin 'Konfekt/FastFold' " Fix very slow vim because of foldmethod=syntax

" tpope
Plugin 'tpope/vim-fugitive' " Gblame, Gremove .... fun
Plugin 'tpope/vim-commentary' " use gcc
Plugin 'tpope/vim-rsi' "allow you to use <ctrl-a> as move to left in command mode
Plugin 'tpope/vim-surround' " To remove the delimiters entirely to 'Hello world!' press ds'.  Hello world!. or ysiw( . or visual mode then S(
Plugin 'tpope/vim-eunuch' "Add unix command like :Remove :Move :SudoWrite
" Plugin 'tpope/gem-ctags'
Plugin 'tpope/vim-projectionist' " Allow to use :A on any project
Plugin 'tpope/vim-bundler' " add gf on Gemfile to open gem source
Plugin 'tpope/vim-rake' " Need vim-projectionist ta add a :A for alternative file
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-characterize' " Add more display when press ga on a char
Plugin 'tpope/vim-repeat' " Allow to repeat custom map
Plugin 'tpope/vim-rbenv'
" Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-abolish' " https://github.com/tpope/vim-abolish#coercion easily convert to snake_Case to CamelCase ... \o/ ;
                           " to snake_case (crs), to camelCase (crc) (like javascript), to ruby ModelName MixedCase (crm)
Plugin 'tpope/vim-vinegar'

Plugin 'jayflo/vim-skip'
Plugin 'altercation/vim-colors-solarized'

" language specific
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx.git'
Plugin 'vim-ruby/vim-ruby'
Plugin 'mattn/emmet-vim' " to write fast html when pressing <C-y>,
Plugin 'lmeijvogel/vim-yaml-helper' " go to key and press :YamlGetFullPath
Plugin 'dag/vim-fish'
Plugin 'msanders/snipmate.vim'

" for opening file
Plugin 'kien/ctrlp.vim'

call vundle#end()            " required
" load the plugin and indent settings for the detected filetype
filetype plugin indent on    " required
" }

let g:mapleader = "\<Space>"

" fish config{
" from https://github.com/tpope/vim-sensible/blob/master/plugin/sensible.vim
if &shell =~# 'fish$'
  set shell=/bin/bash
endif
" }

" setup var to know wich enironnement is running
let s:uname = system("echo -n \"$(uname)\"")

syntax enable

set history=4000

" taken here : https://github.com/thoughtstream/Damian-Conway-s-Vim-Setup/blob/master/.vimrc
"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 50 files
"           | |   +--Remember up to 1000 lines in each register
"           | |   |      +--Remember up to 1MB in each register
"           | |   |      |     +--Remember last 500 search patterns
"           | |   |      |     |     +---Remember last 1000 commands
"           | |   |      |     |     |
"           v v   v      v     v     v
set viminfo=h,'50,<1000,s1000,/500,:1000


" FileType {
" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
augroup change_file_type
  autocmd!
  autocmd BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru,Guardfile} set filetype=ruby
  " add json syntax highlighting
  autocmd BufNewFile,BufRead *.json set filetype=javascript
  autocmd BufNewFile,BufRead *.hbs set filetype=html
augroup END
" }

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" file encoding {
set autoread " Automatically reload changes if detected
set encoding=utf8
set fileencoding=utf-8
set fileencodings=utf-8
" }

" QuickLink to various file {
function! OpenInBufferOrTab(file)
  if line('$') == 1 && getline(1) == ''
    exec 'e' a:file
  else
    exec 'tabnew' a:file
  endif
endfu

command! Vimrc :call OpenInBufferOrTab("$MYVIMRC")
command! SourceVimrc source $MYVIMRC
command! Gvimrc :call OpenInBufferOrTab("$MYGVIMRC")
command! Zshrc :call OpenInBufferOrTab("$HOME/.zshrc")
command! Fishconfig :call OpenInBufferOrTab("$HOME/.config/fish/config.fish")

command! Whyvim :call OpenInBufferOrTab("$HOME/cours-vim.md")
command! Todo :call OpenInBufferOrTab("$HOME/todo.md")
command! Shocked :call OpenInBufferOrTab("$HOME/code-qos-shocked.md")
command! Reunion :call OpenInBufferOrTab("$HOME/next_reunion.md")
" }

" backup swap {
set nobackup "nobk: in this age of version control, who needs it
set nowritebackup "nowb: don't make a backup before overwriting
set noswapfile "noswf: don't litter swap files everywhere
set directory=/tmp "dir: directory for temp files
" }

" colors {
set background=dark
" let g:solarized_termtrans=1 " need to add this light to have a decent render on linux
colorscheme solarized

" stop syntax coloring after 1000 columns
set synmaxcol=1000
" }

" CTags ctags {
" let Tlist_Auto_Update=1
" let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
" Reload tag
" command! Rtags execute "!/usr/local/bin/ctags --extra=+f -R *"
" ctags -R --languages=ruby --exclude=.git --exclude=log .
nnoremap <C-$> :tnext<CR>
" }

" configure display {
set statusline=%y%f%=%m%r%h%w\ %l\/%L\ \|\ %c

" Status bar
set laststatus=2

set cursorline

" Show (partial) command in the status line
set showcmd

" Suppress mode change messages
set noshowmode

"Display &nbsp and trailing space :
set list listchars=nbsp:•,trail:¬

" line number
set number
set numberwidth=1

" set ttyfast "tf: improves redrawing for newer computers
set lazyredraw "lz: will not redraw the screen while running macros (goes faster)

set virtualedit=block
" }

" configure folding {
if &diff
  set foldmethod=diff
else
  set foldmethod=syntax foldlevel=4
endif

augroup change_file_fold
  autocmd!
  autocmd BufRead,BufNewFile *vimrc                        setlocal foldmethod=marker foldmarker={,} foldlevel=0
  autocmd BufRead,BufNewFile *.scss,*.less                 setlocal foldmethod=marker foldmarker={,} foldlevel=3
  autocmd BufRead,BufNewFile *.{yml,yaml,slim,haml,coffee} setlocal foldmethod=indent
augroup END
" }

" configure ruby{
augroup config_ruby
  autocmd!
  " Said it is a good practice to do -= then += but can't find link
  " autocmd FileType ruby setlocal iskeyword-=?,! iskeyword+=?,!
  " with @ as part of a word
  " set iskeyword-=-,?,@-@ iskeyword+=-,?,@-@
augroup END
" }

" configure html/javascript{
augroup config_html_css_js
  autocmd!
  autocmd FileType html,javascript,eruby,css,scss setlocal iskeyword-=-,$ iskeyword+=-,$
augroup END
" }

" configure when open large_files {
" http://vim.wikia.com/wiki/Faster_loading_of_large_files
" Protect large files from sourcing and other overhead.
" Files become read only
if !exists("auto_load_large_file")
  let auto_load_large_file = 1
  " Set options:
  " eventignore+=FileType (no syntax highlighting etc
  " assumes FileType always on)
  " noswapfile (save copy of file)
  " bufhidden=unload (save memory when other file is viewed)
  " buftype=nowritefile (is read-only)
  " undolevels=-1 (no undo possible)
  " Large files are > 2M
  let g:LargeFile = 1024 * 1024 * 2
  augroup LargeFile
    autocmd!
    autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > g:LargeFile | set eventignore+=FileType | setlocal noswapfile bufhidden=unload undolevels=-1 | else | set eventignore-=FileType | endif
  augroup END
endif
" }

" For vim-rails {
" help -> :help rails-projection
let g:rails_projections = {
      \ "lib/import/*.rb": {
      \   "command": "import"
      \ },
      \ "app/decorators/*_decorator.rb": {
      \   "command": "decorator",
      \   "template":
      \     "class %SDecorator < ApplicationDecorator\nend",
      \   "test": [
      \     "spec/decorators/%s_decorator_spec.rb"
      \   ],
      \   "alternate": 'app/models/%s.rb'
      \ },
      \ "spec/factories/*.rb": {
      \   "command": "factory",
      \   "template":
      \     "FactoryGirl.define do\nfactory :%s, class: %S do\nend\nend",
      \   "test": [
      \     "spec/models/%s_spec.rb"
      \   ],
      \ },
      \ "app/repositories/*_repository.rb": {
      \   "command": "repository",
      \   "template":
      \     "class %SRepository\nend",
      \   "test": [
      \     "spec/repositories/%s_repository_spec.rb"
      \   ],
      \ },
      \ "app/presenters/*_presenter.rb": {
      \   "command": "presenter",
      \   "template":
      \     "class %SPresenter\nend",
      \   "test": [
      \     "spec/presenters/%s_presenter_spec.rb"
      \   ],
      \ },
      \ "app/forms/*_form.rb": {
      \   "command": "form",
      \   "template":
      \     "class %Form\nend",
      \   "test": [
      \     "spec/forms/%s_form_spec.rb"
      \   ],
      \ },
      \ "features/support/*.rb": {"command": "support"},
      \ "features/support/env.rb": {"command": "support"}
      \}
" }

" snipmate {
let g:snippets_dir=globpath(&runtimepath, 'my_snippets')
" }

" tabularize {
" see .vim/after/plugin/my_tabular.vim
" }

" wildignore {
" vim-scripts/gitignore update the list too
" Pattern ignore when use the completion in search file
set wildignore+=*.o,*.obj,*~,#*#,*.pyc,*.tar*,*.avi,*.ogg,*.mp3,*.ico
set wildignore+=.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.exe
" case-insensitive filename completion
set wildignorecase
" }

" Completion {
" Completion like bash
" menuone is to always display menu
set completeopt+=longest,menuone
"tab completion for files
set wildmode=list:longest
set dictionary=/Users/tim/.vim/dictionary/francais.txt
set complete-=i " Tim pop says no. So no
" Add dictionnary to <Ctrl-N> " will see if usefull in futur
"set complete-=k complete+=k
" }

" Remember last location in file {
augroup lastlocation
  autocmd!
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | execute "normal! g'\"" | endif
augroup END
" }

" map other {

"open the same directory as the current buffer !
nnoremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
"display the same directory as the current buffer !
cnoremap %% <C-R>=expand("%:p:h") . "/" <CR>
cnoremap %f <C-R>=expand("%:t") <CR>

"taken from https://github.com/carlhuda/janus -> plugin/mappings.vim
nnoremap <F4> :set invpaste<CR>:set paste?<CR>

" format the entire file,
" mf   -> mark line inside f,
" gg=G -> reindent,
" 'f   -> go to current line
nnoremap <Leader>fef mfgg=G'f

"display cursor column
nnoremap <Leader>col :set invcursorcolumn<CR>

"Cut line where cursor is
"Probleme when buffer is unmodifiable :/
" nnoremap <ENTER> r<ENTER>


" like gt (tab next) but with buffer
nnoremap gb :bn<CR>
nnoremap gB :bp<CR>

nnoremap <Leader><Leader> :w<CR>
nnoremap go o<esc>
nnoremap gO O<esc>

" }

" map surround {

" when on a word, change 'word' to '#{word}' (usefull for ruby)
nnoremap <Leader>sa diwi#{<C-r>"}<ESC>
nnoremap <Leader>sA diWi#{<C-r>"}<ESC>

" Works only with vim-surround
nnoremap <Leader>s" ysiw"
" }

" yank copy mapping {

" "+y Copy to 'clipboard registry'
" Work like 'y' but copy in OS clipboard (géniaaaal !!)
" Dont use nmap because we need in vmap
" Don't use noremap because it not understand << Y$ >>
" save in clipboard
vnoremap Y "+y
" save all line in clipboard
nnoremap YY ^"+y$

" Yank the word on which i am
" i<esc> is used to go back after yank with `^
nnoremap <Leader>y i<esc>lyiw`^
" Yank the word on which i am and put it in the clipboard
" i<esc> is used to go back after yank with `^
nnoremap <Leader>Y i<esc>l"+yiw`^

" Make Y behave like C and D.
" taken from https://github.com/tpope/vim-sensible
nnoremap Y y$
" }

" paste mapping {
" If you visually select something and hit paste
" that thing gets yanked into your buffer. This
" generally is annoying when you're copying one item
" and repeatedly pasting it. This changes the paste
" command in visual mode so that it doesn't overwrite
" whatever is in your paste buffer.
" taken here
" http://yanpritzker.com/2012/01/20/the-cleanest-vimrc-youve-ever-seen/
vnoremap p "_dp
vnoremap P "_dP
" replace current word with paste and do not save deleted word to register
nnoremap <Leader>p "_ciw<C-r>"<esc>
"http://vim.wikia.com/wiki/Selecting_your_pasted_text
nnoremap <expr> gp '`[' . strpart(getregtype(), 0, 1) . '`]'
" }

" delete mapping {
"when use x, do not send to test register <""> but send to black hole
"register "_ (ie void, or /dev/null or divide by 0...)
nnoremap x "_x
nnoremap X "_X
vnoremap x "_x
vnoremap X "_X

" delete the word on which i am
nnoremap <Leader>d diw
" delete the word on which i am and put it in the clipboard
nnoremap <Leader>D "+diw

" Remove the word under the cursor
" Do not save the word in any register
" and go in insert mode
nnoremap <Leader>r "_ciw

" }

" movement mapping {
" Delete yank or change until next Majuscule
" o waits for you to enter a movement command : http://learnvimscriptthehardway.stevelosh.com/chapters/15.html
" M is for Maj
" :<c-u>execute -> special way to run multiple normal commande in a map : learnvimscriptthehardway.stevelosh.com/chapters/16.html
onoremap M :<c-u>execute "normal! /[A-Z]\r:nohlsearch\r"<cr>
" }

" Move visual block {
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
" }

" mouse {
if has('mouse')
  set mouse=a
endif
" }

" run ruby {
" taken inside the demo video https://www.destroyallsoftware.com/screencasts
" it run the current ruby file and display result
nnoremap <Leader>l :w\|:!ruby %<CR>
" }

" scroll {
"show three line before up and down => MAGIC
set scrolloff=3
"show 15 char before and after cursor => MAGIC
set sidescrolloff=15
set sidescroll=1
" }

" search {
set incsearch "is: automatically begins searching as you type
set noignorecase "ic: no ignores case
set hlsearch "hls: highlights search results; ctrl-n or :noh to unhighlight
set gdefault "gd: Substitute all matches in a line by default no need s/a/b/g
set nowrapscan "Stop search at end of the file

" search for selected text
" TODO not working perfectly
vnoremap // y/\V<C-R>"<CR>

" when on a word, it search for this word
" and replace with the specified value
nnoremap <Leader>sr :%s/\<<C-r><C-w>\>//c<Left><Left>
nnoremap <Leader>sR :%s/<C-r><C-w>//c<Left><Left>
vnoremap <Leader>sr y:%s/\V<C-r>"//c<Left><Left>

" remove ugly char when pasted searched text
function! Del_word_delims()
  let reg = getreg('/')
  " After *  i^r/ will give me pattern instead of \<pattern\>
  let res = substitute(reg, '^\\<\(.*\)\\>$', '\1', '' )
  if res != reg
    return res
  endif
  " After * on a selection i^r/ will give me pattern instead of \Vpattern
  let res = substitute(reg, '^\\V'          , ''  , '' )
  let res = substitute(res, '\\\\'          , '\\', 'g')
  let res = substitute(res, '\\n'           , '\n', 'g')
  return res
endfunction
inoremap <silent> <C-R>/ <C-R>=Del_word_delims()<CR>
cnoremap          <C-R>/ <C-R>=Del_word_delims()<CR>
nnoremap          "/p "=Del_word_delims()<C-M>p

" The Silver Searcher
" thanks to https://robots.thoughtbot.com/faster-grepping-in-vim
if executable('ag')
  " Use ag over grep
  " need to ad a specifiq agignore, see .zshrc for details
  set grepprg=ag\ -Q\ --nogroup\ --nocolor\ --case-sensitive\ --path-to-agignore\ .agignorecustom
endif

" Like * but on all repo :)
" call histadd("cmd", "e $MYVIMRC")
"
nnoremap <silent> <Leader>* :grep! -w "<C-R>=Del_word_delims()<CR>"<CR>:cw<CR>
" Search what is inside register "/" but on all repo
nnoremap <silent> <Leader>a :grep! "<C-R>=Del_word_delims()<CR>"<CR>:cw<CR>
" Search what is selected on all repo
vnoremap <silent> <Leader>a y:exe "grep! " . shellescape("<C-r>0")<CR><CR>:cw<CR>

augroup specific-quickfix-window
  autocmd!
  " Always move quickfix at bottom for full width
  autocmd FileType qf wincmd J
  " Quit on q
  autocmd FileType qf nnoremap <buffer> q :q<CR>
  " Open new window
  " display quickfix window on bottom
  " and return on the previous opened window
  autocmd FileType qf nnoremap <buffer> <C-h> <C-w><Enter><C-w>H:cclose<CR>:copen<CR><C-w>p
  autocmd FileType qf nnoremap <buffer> <C-j> <C-w><Enter><C-w>J:cclose<CR>:copen<CR><C-w>p
  autocmd FileType qf nnoremap <buffer> <C-k> <C-w><Enter><C-w>K:cclose<CR>:copen<CR><C-w>p
  autocmd FileType qf nnoremap <buffer> <C-l> <C-w><Enter><C-w>L:cclose<CR>:copen<CR><C-w>p
  " Open in a new tab. ^ is to go to first char to apply "gf"
  autocmd FileType qf nnoremap <buffer> <C-t> ^<C-w>gf:copen<CR><C-w>p
augroup END
" }

" ctrlp {
"https://github.com/kien/ctrlp.vim
nnoremap <C-b> :CtrlPBuffer<CR>

if executable('ag')
  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --path-to-agignore .agignorecustom -g ""'
endif
" }

" spell {
" Use vim spell:
" :set spelllang=fr
" :set spell
"
" zg Add word under the cursor as a good word_to_search
" zw Mark the word as a wrong (bad) word.wrong
" z= For the word under/after the cursor suggest correctly
" spelled words.

" Spell Check, used to togle between no spell and language. To add a language
" juste download a language from here : http://ftp.vim.org/vim/runtime/spell/
" , and copy paste in ~/.vim/spell/
" let b:myLang=0
" let g:myLangList=["nospell","fr","en"]
" function! ToggleSpell()
"   let b:myLang=b:myLang+1
"   if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
"   if b:myLang==0
"     setlocal nospell
"   else
" execute "setlocal spell spelllang=".get(g:myLangList, b:myLang)
"   endif
"   echo "spell checking language:" g:myLangList[b:myLang]
" endfunction

" nnoremap <F7> :call ToggleSpell()<CR>

"spell check when writing commit logs
"autocmd filetype svn,*commit* set spell
" }

" up down movement {
" when go to left at a start of line, it goes to the end of previous
set whichwrap+=<,>,h,l,[,]

" Map the arrow keys to be based on display lines, not physical lines
nnoremap <Down> gj
nnoremap <Up> gk
" }

" Whitespace space tab stuff {
set nowrap
set tabstop=2 "ts: number of spaces that a tab renders as
set shiftwidth=2 "sw: number of spaces to use for autoindent
set softtabstop=2 "sts: number of spaces that tabs insert
set smarttab "sta: helps with backspacing because of expandtab
set expandtab "et: uses spaces instead of tab characters

" make uses real tabs
augroup tab_and_space
  autocmd!
  autocmd FileType make set noexpandtab
  " make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
  autocmd FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79 noexpandtab

  " Delete all trailing whitespace in end of line
  autocmd BufWritePre * :%s/\s\+$//e
augroup END
" }

" move in window stuff {
" ----------------------------------------------------------------------------
" move to the window in the direction shown, or create a new split in that
" direction
" ----------------------------------------------------------------------------
func! WinMove(key)
  let t:curwin = winnr()
  exec "wincmd ".a:key
  if (t:curwin == winnr())
    if (match(a:key,'[jk]'))
      wincmd v
    else
      wincmd s
    endif
    exec "wincmd ".a:key
  endif
endfu

nnoremap <silent> <C-h> :call WinMove('h')<cr>
nnoremap <silent> <C-j> :call WinMove('j')<cr>
nnoremap <silent> <C-k> :call WinMove('k')<cr>
nnoremap <silent> <C-l> :call WinMove('l')<cr>

" Switch directly to the new splitted window
nnoremap <C-w>v :vsplit<CR>
nnoremap <C-w>s :split<CR>

nnoremap <silent> <Leader>j :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>k :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>h :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>l :exe "vertical resize " . (winwidth(0) * 2/3)<CR>

" split under
set splitbelow
" split right
set splitright
" }

" syntastic {
if !v:shell_error && s:uname == "Linux"
" let g:syntastic_mode_map = { 'mode': 'passive' }
else
  let g:syntastic_ruby_exec = '/usr/local/opt/rbenv/versions/2.1.5/bin/ruby'
endif

let g:syntastic_always_populate_loc_list=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
" Always open loc list
" let g:syntastic_auto_loc_list=1
let g:syntastic_aggregate_errors = 1
" }

" special qos energy {
if !v:shell_error && s:uname == "Linux"
  nnoremap <PageDown> <Nop>
  inoremap <PageDown> <Nop>
  nnoremap <PageUp> <Nop>
  inoremap <PageUp> <Nop>
  nnoremap <Del> <Nop>

  abbrev EF EnergyField
  abbrev ef energy_field
  abbrev DM DailyMesure
  abbrev dm daily_mesure
  abbrev MM MonthlyMesure
  abbrev mm monthly_mesure
  abbrev MMS MonthlyMesures
  abbrev mms monthly_mesures
  abbrev FP FreePeriod
  abbrev FPS FreePeriodStore
  abbrev SR SensorReference
  abbrev sr sensor_reference
endif

" Convert new hash a: 4 to old hash :a => 4
" oh is for old hash
nnoremap <Leader>oh :s/\([a-z_]\+\): /:\1 =><CR>

" }

" sudo {
" Allow saving of files as sudo when I forgot to start vim using sudo.
" or :SudoEdit
cabbrev w!! w !sudo tee > /dev/null %
" }

" tpope vinegar{
let g:netrw_liststyle=3
nmap <Leader>n <Plug>VinegarUp
" keep - the old way because tpope remapped it
nnoremap - -
" }

" Tips and tricks {

"## g with norm
"http://briancarper.net/blog/165/
"example:
":g/\d/norm o999

"## Encoding
"http://stackoverflow.com/questions/778069/how-can-i-change-a-files-encoding-with-vim
"Notice that there is a difference between
"set encoding
"and
"set fileencoding

"Donc pour modifier un fichier, faire :
"set fileencoding=utf-8
":wq
"
" ## use hexa editor
"Use vim as HEXA editor :
"open your file as usual
"[esc] :%!xxd
"<now editing mycat in hex>
"<find some innocuous string or rcsid>
"<change the values on the hex side>
"[esc] :%!xxd -r
"[esc] :wq!
"
" ## To add an abbrev for a specifiq filetype :
" autocmd FileType javascript :iabbrev <buffer> cl console.log();<left><left>
"
" Why I group autocmd ? (because to reload vimrc)
" http://learnvimscriptthehardway.stevelosh.com/chapters/14.html<F37>

" To profile all
" :profile start profile.log
" :profile func *
" :profile file *
" :profile pause
" :profile continue
" :q
" }