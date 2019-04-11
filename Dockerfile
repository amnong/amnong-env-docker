FROM ubuntu

RUN apt update
# General packages
RUN apt install -y wget
RUN apt install -y curl
RUN apt install -y tmux
RUN apt install -y git
# Zsh
RUN apt install -y zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN cd ~/.oh-my-zsh/custom/plugins && \
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
# Vim
RUN apt install -y vim
RUN git clone --depth=1 https://github.com/amix/vimrc.git /root/.vim_runtime && sh /root/.vim_runtime/install_awesome_vimrc.sh
# Python
RUN apt install -y python3 python3-dev
RUN apt install -y python3-pip
RUN python3 -m pip install -U pip
RUN python3 -m pip install virtualenvwrapper

ADD home /root

RUN mkdir /root/workspace
WORKDIR /root/workspace
CMD ["/usr/bin/zsh"]

