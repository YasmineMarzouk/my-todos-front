# the base for out container
FROM nginx
# declare a work directory.
# you are free to select any folder you like.
# if directory does not exist, it's going to be created.
WORKDIR /usr/share/react
# command to install node.js using curl.
RUN curl -fsSL https://deb.nodesource.com/setup_17.x | bash -
RUN apt-get install -y nodejs
# copy package.json & packagelock.json into the work directory.
COPY package*.json ./
# install packages.
RUN npm install
# copy all files into work directory.
COPY . .
# run build
RUN npm run build
# remove anything that already exists inside share/nginx/html folder.
# this will get rid of any build that may be cached there already.
RUN rm -r /usr/share/nginx/html/*
# copy the build folder into nginx/html instead of mapping to it.
RUN cp -a build/. /usr/share/nginx/html