# https://github.com/GoogleContainerTools/distroless/blob/main/examples/nodejs/Dockerfile
FROM node:14 AS prd-env
COPY . /app
WORKDIR /app
RUN yarn install --production --frozen-lockfile

FROM prd-env AS build-env
WORKDIR /app
RUN yarn install --frozen-lockfile \
    && yarn run build

FROM gcr.io/distroless/nodejs:14
COPY --from=build-env /app/build /app
COPY --from=prd-env /app/node_modules /app/node_modules
WORKDIR /app
ARG ENV="production"
ENV NODE_ENV=$ENV
EXPOSE 3000
CMD ["src/server.js"]
