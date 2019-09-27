FROM balenalib/aarch64-ubuntu-node:10-cosmic

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y libsqlite3-dev build-essential python-dev

COPY . . 

RUN npm install 


