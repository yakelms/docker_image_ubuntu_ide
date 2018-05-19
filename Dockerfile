# Version: 0.0.1
FROM ubuntu
MAINTAINER Mingshan Lin "yakel@126.com"
ENV TZ=Asia/Shanghai
ADD ./zoneinfo/Asia /usr/share/zoneinfo/Asia/
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY ./etc /etc/
RUN apt-get update
RUN apt-get install -y vim
RUN ["apt-get", "install", "-y", "apt-utils"]
RUN ["apt-get", "install", "-y", "cscope", "git", "curl", "silversearcher-ag", "ctags"]
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
RUN curl https://beyondgrep.com/ack-2.22-single-file > /usr/bin/ack && chmod 0755 /usr/bin/ack
RUN mkdir -p ~/.vim_runtime/my_plugins/cscope/ && curl http://cscope.sourceforge.net/cscope_maps.vim > ~/.vim_runtime/my_plugins/cscope/cscope_maps.vim && echo "source ~/.vim_runtime/my_plugins/cscope/cscope_maps.vim" >> ~/.vimrc
COPY ./scripts /root/scripts/
RUN ["sh", "/root/scripts/update_cscope_map.sh"]
RUN mkdir -p ~/.vim_runtime/my_plugins/taglist.vim/ && git clone https://github.com/vim-scripts/taglist.vim ~/.vim_runtime/my_plugins/taglist.vim/ && echo "source ~/.vim_runtime/my_plugins/taglist.vim/plugin/taglist.vim" >> ~/.vimrc
VOLUME ["/root/share"]
#ENTRYPOINT ["/bin/bash"]
CMD ["/bin/bash"]
