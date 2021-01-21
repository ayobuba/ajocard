# Node
EXPOSE 5000
CMD [ "npm", "start" ]
FROM node:12 as node-image
LABEL maintainer="Shekarau Edward Buba <shekarau.buba@outlook.com"
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install --only=production
COPY ["app.js", "package.json", "./"]
COPY test views ./
EXPOSE 5000
CMD [ "npm", "start" ]