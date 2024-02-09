FROM node:17-alpine AS builder
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm build

FROM nginx:1.19.0
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=builder /app/build .
ENTRYPOINT [ "nginx", "-g", "daemon off;" ]