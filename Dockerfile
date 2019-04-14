FROM ubuntu

RUN apt update
# General packages
RUN apt install -y wget
RUN apt install -y curl
RUN apt install -y git
# Zsh
RUN apt install -y zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN cd ~/.oh-my-zsh/custom/plugins && \
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
# Vim
RUN apt install -y vim
RUN git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime && sh ~/.vim_runtime/install_awesome_vimrc.sh
# Tmux
RUN apt install -y tmux
RUN git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ADD home/.tmux.conf /root/
RUN ~/.tmux/plugins/tpm/scripts/install_plugins.sh
# Python
RUN apt install -y python3 python3-dev
RUN apt install -y python3-pip
RUN python3 -m pip install -U pip
RUN python3 -m pip install virtualenvwrapper
# Networking
RUN apt install inetutils-ping net-tools

# Homedir configuration files, assuming "docker run -v ~:/root/host ..."
RUN mkdir ~/host && echo "Add '-v \$HOME:/root/host' to your 'docker run' command to use host configuration files." > ~/host/README
RUN ln -s ~/host/.gitconfig ~/.gitconfig
RUN ln -s ~/host/.pip ~/.pip
RUN ln -s ~/host/.pydistutils.cfg ~/.pydistutils.cfg
RUN ln -s ~/host/.ssh ~/.ssh

ADD home /root

WORKDIR /root
CMD ["/usr/bin/zsh"]

