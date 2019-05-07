FROM ubuntu:18.04

ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
ENV MAIN_PATH=/usr/local/bin/python_dev
ENV LIBS_PATH=${MAIN_PATH}/libs
ENV CONFIG_PATH=${MAIN_PATH}/config
ENV NOTEBOOK_PATH=${MAIN_PATH}/notebooks

RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y build-essential  \
    checkinstall \
    libreadline-gplv2-dev \
    libncursesw5-dev \
    libssl-dev \
    libsqlite3-dev \
    tk-dev \
    libgdbm-dev \
    libc6-dev \
    libbz2-dev \
    zlib1g-dev \
    openssl \
    libffi-dev \
    python3-dev \
    python3-setuptools \
    wget \
    zsh \
    nano \
    fonts-powerline

RUN mkdir /tmp/Python37 \
    && cd /tmp/Python37 \
    && wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tar.xz \
    && tar xvf Python-3.7.0.tar.xz \
    && cd /tmp/Python37/Python-3.7.0 \
    && ./configure \
    && make altinstall

RUN ln -s /usr/local/bin/python3.7 /usr/bin/python
RUN wget https://bootstrap.pypa.io/get-pip.py && python get-pip.py

RUN pip install --upgrade pip\
    requests \
    jupyter \
    jupyterlab \
    pycrypto


RUN apt-get install pandoc -y
RUN apt-get install texlive-xetex -y 

RUN unlink /usr/bin/python
RUN ln -s /usr/local/bin/python3.7 /usr/bin/python

RUN apt-get install bash -y
RUN pip install bash_kernel
RUN python -m bash_kernel.install

RUN apt-get install nodejs -y
RUN apt-get install npm -y

# terminal colors with xterm
ENV TERM xterm
# set the zsh theme
ENV ZSH_THEME agnoster

# run the installation script  
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true


EXPOSE 8888

CMD cd ${MAIN_PATH} && [ "zsh" ]
