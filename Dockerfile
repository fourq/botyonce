FROM ubuntu

RUN apt-get update
RUN apt-get -y install expect redis-server nodejs npm
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN npm install -g coffee-script
RUN npm install -g yo generator-hubot

# Create hubot user
RUN useradd -d /hubot -m -s /bin/bash -U hubot

# Log in as hubot user and change directory
USER    hubot
WORKDIR /hubot

# Install hubot
RUN yo hubot --owner="Rocky Assad" --name="botyonce" --description="botyonce on Docker" --defaults

ADD hubot-scripts.json /hubot/

RUN npm install hubot-standup-alarm --save && npm install
ADD external-scripts.json /hubot/

RUN npm install hubot-hipchat --save && npm install
CMD bin/hubot -a hipchat
