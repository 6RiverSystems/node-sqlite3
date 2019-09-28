FROM balenalib/aarch64-ubuntu-node:10-cosmic

RUN [ "cross-build-start" ]

RUN apt-get update && apt-get install -y libsqlite3-dev build-essential python-dev

COPY . . 

RUN npm install --build-from-source --sqlite=/usr/local

RUN ./node_modules/.bin/node-pre-gyp build package
# 
# RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
# 

# RUN apt-get install apt-transport-https ca-certificates curl 
# 
# RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
# 
# RUN apt-get update && apt-get install google-cloud-sdk

RUN [ "cross-build-end" ]


FROM google/cloud-sdk:alpine 
WORKDIR /
COPY --from=0 /build/stage/sqlite3/v4.1.0/node-v64-linux-arm64.tar.gz .
