FROM node:12 as build-step
RUN mkdir -p /app
WORKDIR /app
COPY package.json package-lock.json /app/
RUN npm install
COPY . /app
RUN npm run build --prod

FROM nginx:1.23-alpine
COPY ./nginx/nginx.conf.template /etc/nginx/templates/default.conf.template
COPY --from=build-step /app/dist /usr/share/nginx/html

EXPOSE 80 
EXPOSE 8081