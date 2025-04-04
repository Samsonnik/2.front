FROM node:21-alpine AS build

WORKDIR /app

COPY ./front-end ./

RUN npm install

COPY ./front-end .

RUN npm run build

FROM nginx

RUN rm -rf /etc/nginx/conf.d/* && \
    rm -rf /usr/share/nginx/html/*

COPY --from=build /app/build /usr/share/nginx/html

RUN nginx -t

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
