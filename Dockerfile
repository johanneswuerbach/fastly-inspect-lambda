FROM node:14-alpine

RUN apk add --no-cache curl zip

RUN mkdir /lambda

ENV FASTLY_INSPECT_VERSION v0.1.5

RUN curl -o /tmp/fastly-inspect.tar.gz -fsL https://github.com/yannh/fastly-inspect/releases/download/${FASTLY_INSPECT_VERSION}/fastly-inspect_${FASTLY_INSPECT_VERSION}_linux-amd64.tar.gz && \
   mkdir -p /tmp/fastly-inspect && \
   tar xvf /tmp/fastly-inspect.tar.gz -C /tmp/fastly-inspect && \
   cp /tmp/fastly-inspect/fastly-inspect /lambda && \
   rm -r /tmp/fastly-inspect.tar.gz /tmp/fastly-inspect && \
   chmod +x /lambda/fastly-inspect

COPY . /app

WORKDIR /app

RUN npm i && npm run prepare

RUN cp /app/built/index.js /lambda/index.js

WORKDIR /lambda

RUN zip function.zip index.js fastly-inspect
