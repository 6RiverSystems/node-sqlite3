FROM balenalib/aarch64-ubuntu-node:10-cosmic

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y libsqlite3-dev build-essential python-dev

COPY . . 

RUN npm install --build-from-source --sqlite=/usr/local

RUN ./node_modules/.bin/node-pre-gyp build package