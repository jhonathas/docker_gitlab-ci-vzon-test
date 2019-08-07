FROM vborja/asdf-ubuntu

MAINTAINER Jhonathas Matos <jhonathas@gmail.com>

# Pull latest asdf

RUN asdf update --head

# Frontend

RUN asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
RUN bash ~/.asdf/plugins/nodejs/bin/import-release-team-keyring
RUN asdf install nodejs 8.9.4
RUN asdf global nodejs 8.9.4
RUN npm install npm@6.4.1 -g

# Backend
USER root

RUN apt-get update
RUN apt-get install -y build-essential autoconf libncurses5-dev libssh-dev unzip

USER asdf

RUN asdf plugin-add erlang
RUN asdf plugin-add elixir

RUN asdf install erlang 21.0.7
RUN asdf global erlang 21.0.7

RUN asdf install elixir 1.7.3
RUN asdf global elixir 1.7.3
