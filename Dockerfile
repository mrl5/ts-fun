# https://github.com/GoogleContainerTools/distroless/blob/main/examples/nodejs/Dockerfile
FROM node:14 AS prd-env
COPY . /app
WORKDIR /app
RUN npm ci --only=production

FROM prd-env AS build-env
WORKDIR /app
RUN npm i \
    && npm run build

FROM gcr.io/distroless/nodejs:14
COPY --from=build-env /app/dist /app
COPY --from=prd-env /app/node_modules /app/node_modules
WORKDIR /app
ARG ENV="production"
ENV NODE_ENV=$ENV
EXPOSE 3000
CMD ["main.js"]
