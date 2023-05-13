FROM node:20-alpine
WORKDIR /app
ARG VERSION=1989.6.38
RUN npm install "halbot@${VERSION}"
ENTRYPOINT [ "/app/node_modules/.bin/halbot" ]
