FROM node:23.3-alpine3.19

WORKDIR /app
COPY package.json package-lock.json /app
RUN npm ci

CMD node esbuild.js --watch