FROM node:12.20
RUN useradd --create-home --shell /bin/bash freecodecamp
USER freecodecamp
WORKDIR /home/freecodecamp
COPY --chown=freecodecamp:freecodecamp . .
# TODO: pass in the secrets
# TODO: dockerignore .env and make 100% sure all the ignored files don't get
# transferred across (including node_modules and any build artifacts)
RUN npm ci
# move the serve installation into the second build stage
RUN npm i serve
# TODO: after the next step we could create a tiny image by adding a second
# stage that copies over the build artifact (/client/public) and just has
# serve and the static files
RUN npm run build:client
CMD ["./node_modules/.bin/serve", "-l", "8000", "client/public"]
