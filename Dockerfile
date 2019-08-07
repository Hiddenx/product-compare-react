# Build stage
FROM node:12.2.0-alpine as build-container

WORKDIR /app

# add env path 
ENV PATH /app/node_modules/.bin:$PATH

# install dependencies
COPY package.json /app/package.json
COPY ../
RUN npm install --silent
RUN npm run build

# Deploy stage
FROM nginx:1.12-alpine
COPY --from=build-container /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
