FROM node:12.20

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

RUN useradd --create-home --shell /bin/bash freecodecamp
USER freecodecamp
WORKDIR /home/freecodecamp
COPY --chown=freecodecamp:freecodecamp . .
# TODO: pass in the secrets. Actually... nothing in the client should be
# considered to be a secret, simply because it ends up in the html/js. As such
# we should make sure that none are secret and then pass them in as build args
RUN npm ci
# move the serve installation into the second build stage
RUN npm i serve
# TODO: after the next step we could create a tiny image by adding a second
# stage that copies over the build artifact (/client/public) and just has
# serve and the static files
RUN npm run build:client
CMD ["./node_modules/.bin/serve", "-l", "8000", "client/public"]
