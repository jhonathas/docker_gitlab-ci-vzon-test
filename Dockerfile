FROM ubuntu:latest

MAINTAINER Jhonathas Matos <jhonathas@gmail.com>

RUN apt-get update -q && apt-get install -y git curl gpg wget

WORKDIR /code

RUN git clone --depth 1 https://github.com/asdf-vm/asdf.git /root/.asdf
RUN echo '. /root/.asdf/asdf.sh' >> /root/.bashrc
RUN echo '. /root/.asdf/asdf.sh' >> /root/.profile

ENV PATH="${PATH}:/root/.asdf/shims:/root/.asdf/bin"

# Pull latest asdf

RUN asdf update --head

# Frontend

RUN asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
RUN asdf install nodejs 8.9.4
RUN asdf global nodejs 8.9.4
RUN npm install npm@6.4.1 -g

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
RUN apt-get update -yqqq
RUN apt-get install -y google-chrome-stable > /dev/null 2>&1

# Backend

RUN apt-get install -y build-essential autoconf libncurses5-dev libssh-dev unzip
RUN apt-get install -y postgresql-client

RUN asdf plugin-add erlang
RUN asdf plugin-add elixir

RUN asdf install erlang 21.0.7
RUN asdf global erlang 21.0.7

RUN asdf install elixir 1.7.3
RUN asdf global elixir 1.7.3
