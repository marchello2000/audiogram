FROM ubuntu:16.04

# Install dependencies
RUN apt-get update --yes && apt-get upgrade --yes
RUN apt-get install git npm curl \
libcairo2-dev libjpeg8-dev libpango1.0-dev libgif-dev libpng-dev build-essential g++ \
ffmpeg \
redis-server --yes

#RUN ln -s `which nodejs` /usr/bin/node

# Non-privileged user
RUN useradd -m audiogram
USER audiogram
WORKDIR /home/audiogram

# Clone repo
RUN git clone https://github.com/nypublicradio/audiogram.git
WORKDIR /home/audiogram/audiogram

# Install dependencies
ENV NVM_DIR /home/audiogram/.nvm

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash \
	&& . $NVM_DIR/nvm.sh \
    && nvm install lts/argon \
    && nvm use lts/argon \
    && npm install \
