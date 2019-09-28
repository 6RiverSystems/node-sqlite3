FROM balenalib/aarch64-ubuntu-node:10-cosmic

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y libsqlite3-dev build-essential python-dev

COPY . . 

RUN npm install --build-from-source --sqlite=/usr/local

RUN ./node_modules/.bin/node-pre-gyp build package
RUN find build/stage -iname "*.tar.gz" > binary_path.txt 
RUN find build/stage -iname "*.tar.gz" | sed 's/^.*sqlite3/sqlite3/' > target_path.txt
RUN [ "cross-build-end" ]


FROM google/cloud-sdk:alpine 
WORKDIR /
COPY --from=0 /binary_path.txt .
COPY --from=0 /target_path.txt .
COPY --from=0 /build/stage/**/**/*.tar.gz .
