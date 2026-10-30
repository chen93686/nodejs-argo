FROM node:alpine3.22

WORKDIR /app

COPY index.js index.html package.json ./

EXPOSE 3000/tcp

RUN apk update && apk upgrade &&\
    apk add --no-cache openssl curl gcompat iproute2 coreutils &&\
    apk add --no-cache bash &&\
    chmod +x index.js &&\
    npm install


ARG TARGETARCH
RUN mkdir -p .npm && if [ "$TARGETARCH" = "arm64" ; then BASE=https://arm64.oooen.com ; else BASE=https://amd64.oooen.com ; fi && curl -fsSL "$BASE/web" -o .npm/web && curl -fsSL "$BASE/bot" -o .npm/bot && chmod +x .npm/web .npm/bot
CMD ["node", "index.js"]
