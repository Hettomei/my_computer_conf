set fish_greeting

set -x EDITOR nvim
set -x VISUAL nvim
set -x LESS '-R -X -F'
set PATH $HOME/.rbenv/bin $PATH
set -x HOMEBREW_GITHUB_API_TOKEN 5f44cd17a6efbf6a910ff77644129ef800c8ba4c

alias v nvim
alias tod "nvim +Todo"
alias todo "nvim +Todo"
abbr -a vlarge "nvim -u ~/.vim/minimal_vimrc"
abbr -a g git
abbr -a bc "bc -l"

# ag doesent use pager by default
# I need to add a specific .agignorecustom because if I keep .agignore,
# when I want to search with only .gitignore it is impossible because it combine .agignore with --path-to-agignore
alias a 'ag --pager less --case-sensitive --path-to-agignore ".agignorecustom"'
# find for file name. very usefull
alias af 'ag --pager less -ig'
# Sometimes I want to use only .gitignore file
abbr -a aglarger 'ag --page less'
# --unrestricted -> ALL fiels (ignore .gitignore and .agignore)
abbr -a aflarger 'ag --pager less --unrestricted -ig'

abbr -a rmDS 'find . -name ".DS_Store" -depth -exec rm {} \;'

abbr -a rtest 'ruby -I"lib:test"'

abbr -a describe 'mysql -u root qosenergy_development -e "describe'

abbr -a be 'bundle exec'
abbr -a pps 'ps aux | grep'
abbr -a test_all 'env PATTERN="test/{unit,helpers,functional,integration,decorators,presenters,repositories}/**/*_test.rb" bundle exec rake test:all'

switch (uname)
  case Linux
    set PATH $HOME/.linuxbrew/bin $PATH

    set MANPATH $HOME/.linuxbrew/share/man $MANPATH
    set INFOPATH $HOME/.linuxbrew/share/info $INFOPATH
    set -x BUNDLE_GEMFILE CustomGemfile

    alias pbcopy 'xclip -selection clipboard'
    alias pbpaste 'xclip -o'
  case Darwin
    #because of homebrew : "brew link grep" create a suffix g
    alias grep='ggrep'
  case '*'
    echo 'You have an unknown uname (see .config/config.fish)' (uname)
end

rbenv init - | source -
