#!/bin/bash
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

echo finished!
