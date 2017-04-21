#! /bin/bash
#get the dir where this script is launched
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

for file_name in 'vimrc' 'gvimrc'
do
  cp -v $DIR/vim/$file_name $HOME/.vim/$file_name
done
