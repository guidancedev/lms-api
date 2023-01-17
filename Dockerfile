FROM node:16-alpine as test-target

WORKDIR /usr/src/app

COPY package*.json ./

# CI and release builds should use npm ci to fully respect the lockfile.
# Local development may use npm install for opportunistic package updates.
#ARG npm_install_command=ci
RUN yarn dev

COPY . .

# Build
FROM test-target as build-target
#ENV NODE_ENV=production

# Use build tools, installed as development packages, to produce a release build.
#RUN yarn dev

# Reduce installed packages to production-only.
#RUN npm prune --production

# Archive
FROM node:16-alpine as archive-target
#ENV NODE_ENV=production
ENV PATH $PATH:/usr/src/app/node_modules/.bin

WORKDIR /usr/src/app

# Include only the release build and production packages.
COPY --from=build-target /usr/src/app/node_modules node_modules
COPY --from=build-target /usr/src/app/.next .next

CMD ["next", "start"]
