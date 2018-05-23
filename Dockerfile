# Version: 0.0.3
FROM ubuntu:18.04
MAINTAINER Mingshan Lin "yakel@126.com"
ENV TZ=Asia/Shanghai
ADD ./zoneinfo/Asia /usr/share/zoneinfo/Asia/
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && apt-get update \
    && apt-get install -y vim \
                          cscope \
                          git \
                          curl \
                          silversearcher-ag \
                          ctags \
    && apt-get clean \
# install awesome vimrc
    && git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime \
    && sh ~/.vim_runtime/install_awesome_vimrc.sh \
# get ack perl scripts
    && curl https://beyondgrep.com/ack-2.22-single-file > /usr/bin/ack \
    && chmod 0755 /usr/bin/ack \
# get cscope plugin
    && mkdir -p ~/.vim_runtime/my_plugins/cscope \
    && curl http://cscope.sourceforge.net/cscope_maps.vim > ~/.vim_runtime/my_plugins/cscope/cscope_maps.vim \
    && echo "source ~/.vim_runtime/my_plugins/cscope/cscope_maps.vim" >> ~/.vimrc \
# get taglist plugin
    && git clone https://github.com/vim-scripts/taglist.vim ~/.vim_runtime/my_plugins/taglist.vim/ \
    && echo "source ~/.vim_runtime/my_plugins/taglist.vim/plugin/taglist.vim" >> ~/.vimrc \
# set NERDTreeClose map
    && sed -r -i "s/(map.+:NERDTreeFind.+)/\1\nmap <leader>nc :NERDTreeClose<cr>\n/g" ~/.vim_runtime/vimrcs/plugins_config.vim \
# set cscope map
    && sed -r -i "s/(^endif)/\tnmap <C-\>k :cs kill cscope.out<CR>\n\
\tnmap <C-\>w :w<CR>:!cscope -Rbq<CR><CR>\n\
\tnmap <C-\>a :cs add cscope.out<CR>\n\
\tnmap <C-\>\ <C-\>w<C-\>k<C-\>a\n\1/g" ~/.vim_runtime/my_plugins/cscope/cscope_maps.vim
 
CMD ["/bin/bash"]
