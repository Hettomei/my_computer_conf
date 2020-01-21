#! /bin/bash

# get the dir where this script is launched
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

DIR="$CURRENT_DIR/${1:-default}"

mkdir "$HOME/.doom.d"
# Add here a list of file you want to copy
for file_name in 'init.el' 'config.el' 'packages.el'
do
  cp -v "$DIR/doom.d/$file_name" "$HOME/.doom.d/$file_name"
done

# Cannot do :
# cp -v -r "$DIR/doom.d" "$HOME"
# mv -vt "$HOME/doom.d" "$HOME/.doom.d"
# Because it may suppress file that was not versionned in home

cat <<EOF

Please go to https://github.com/hlissner/doom-emacs to install it

please run
~/.emacs.d/bin/doom refresh

EOF
