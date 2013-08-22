#! /bin/bash
#get the dir where this script is launched
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Copy file into" $DIR

for file_name in 'vimrc' 'gvimrc' 'gitconfig' 'zshrc' 'irbrc' 'ackrc'
do
  cp -v $HOME/.$file_name $DIR/$file_name
done

cp -v -R $HOME/.vim/plugin/settings $DIR/vim/plugin/

cd $DIR

git add -p
git commit
