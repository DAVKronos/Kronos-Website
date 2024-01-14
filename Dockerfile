# Base image
FROM node:current-alpine3.18

WORKDIR /app
COPY package.json yarn.lock /app
RUN yarn install --frozen-lockfile && yarn cache clean
RUN npm install

CMD ["npm", "run", "build"]