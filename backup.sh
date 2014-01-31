#! /bin/bash
#get the dir where this script is launched
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Copy file into" $DIR

for file_name in 'gitconfig' 'zshrc' 'irbrc' 'ackrc'
do
  cp -v $HOME/.$file_name $DIR/$file_name
done

for file_name in 'vimrc' 'gvimrc' 'vimpagerrc'
do
  cp -v $HOME/.vim/$file_name $DIR/vim/$file_name
done

rm $DIR/vim/plugin/settings/*
cp -v -R $HOME/.vim/plugin/settings $DIR/vim/plugin/

rm $DIR/vim/my_snippets/*
cp -v -R $HOME/.vim/my_snippets $DIR/vim/my_snippets/

cd $DIR

git add -p
git commit
