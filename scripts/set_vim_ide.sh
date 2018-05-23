#!/bin/bash
# install awesome
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
# set NERDTreeClose map
plugin_map=~/.vim_runtime/vimrcs/plugins_config.vim
addstr="map \<leader\>nc :NERDTreeClose\<cr\>\\n"
sed -r -i "s/(^map.+:NERDTreeFind.+)/\1\n${addstr}/g" ${plugin_map}

# install ack
curl https://beyondgrep.com/ack-2.22-single-file > /usr/bin/ack
chmod 0755 /usr/bin/ack

# install cscope plugin and set key map
mkdir -p ~/.vim_runtime/my_plugins/cscope
curl http://cscope.sourceforge.net/cscope_maps.vim > ~/.vim_runtime/my_plugins/cscope/cscope_maps.vim
echo "source ~/.vim_runtime/my_plugins/cscope/cscope_maps.vim" >> ~/.vimrc
echo update vim map
cscope_map=~/.vim_runtime/my_plugins/cscope/cscope_maps.vim
if [ `grep kmapflags -c ${cscope_map}` = 0 ]
then
    str1="\\t\"\"\"\"\"\"\" [kmapflags] key map for updating database file\\n"
    str2="\\tnmap \<C-\\\>k :cs kill cscope.out\<CR\>\\n"
    str3="\\tnmap \<C-\\\>w :w\<CR\>:!cscope -Rbq\<CR\>\<CR\>\\n"
    str4="\\tnmap \<C-\\\>a :cs add cscope.out\<CR\>\\n"
    str5="\\tnmap \<C-\\\>\\ \<C-\\\>w\<C-\\\>k\<C-\\\>a\\n"

    sed -i "s/^endif/${str1}endif/g" ${cscope_map}
    sed -i "s/^endif/${str2}endif/g" ${cscope_map}
    sed -i "s/^endif/${str3}endif/g" ${cscope_map}
    sed -i "s/^endif/${str4}endif/g" ${cscope_map}
    sed -i "s/^endif/${str5}endif/g" ${cscope_map}
    sed -i "s/^endif/\nendif/g" ${cscope_map}
else
    echo already mapped...
fi

# install taglist
mkdir -p ~/.vim_runtime/my_plugins/taglist.vim/
git clone https://github.com/vim-scripts/taglist.vim ~/.vim_runtime/my_plugins/taglist.vim/
echo "source ~/.vim_runtime/my_plugins/taglist.vim/plugin/taglist.vim" >> ~/.vimrc

echo finished!
