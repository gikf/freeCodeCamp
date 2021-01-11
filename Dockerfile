FROM node:12.20-buster AS builder

ARG FREECODECAMP_NODE_ENV
ARG HOME_LOCATION
ARG API_LOCATION
ARG FORUM_LOCATION
ARG NEWS_LOCATION
ARG LOCALE
ARG STRIPE_PUBLIC_KEY
ARG ALGOLIA_APP_ID
ARG ALGOLIA_API_KEY
ARG PAYPAL_CLIENT_ID
ARG DEPLOYMENT_ENV
ARG SHOW_UPCOMING_CHANGES

USER node
WORKDIR /home/node
COPY --chown=node:node . .
RUN npm ci
RUN npm run build:client

FROM node:12.20-alpine
USER node
WORKDIR /home/node
COPY --from=builder /home/node/client/public/ client/public
RUN npm i serve

CMD ["./node_modules/.bin/serve", "-l", "8000", "client/public"]
