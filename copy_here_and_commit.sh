#! /bin/bash
#get the dir where this script is launched
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Copy file into" $DIR

for file_name in 'gitconfig' 'zshrc' 'irbrc' 'ackrc'
do
  cp -v $HOME/.$file_name $DIR/$file_name
done


#### VIM ####
rm -r $DIR/vim
mkdir $DIR/vim

for file_name in 'vimrc' 'gvimrc'
do
  cp -v $HOME/.vim/$file_name $DIR/vim/$file_name
done

for file_name in 'my_snippets' 'dictionary'
do
  cp -v -R $HOME/.vim/$file_name $DIR/vim/
done

cd $DIR

git add -p
git commit
