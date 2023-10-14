FROM node:16-alpine as node
WORKDIR /app
COPY ./web .
RUN npm install --force
RUN npm run build

FROM nginx:1.13 as prod
COPY --from=node app/dist usr/share/nginx/html
COPY web/nginx.conf etc/nginx/conf.d/default.conf
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
