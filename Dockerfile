# Stage 1
FROM node:current-alpine as build
RUN mkdir -p /app
WORKDIR /app
COPY package.json /app
COPY ng-uikit-pro-standard-10.0.0.tgz /app
RUN npm install
COPY . /app
RUN npm run build

# Stage 2
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
