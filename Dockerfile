#Build Phase
FROM node:16-alpine as builder
USER node
RUN mkdir -p /home/node/app
WORKDIR /home/node/app
COPY --chown=node:node ./package.json ./
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build
#After build success, the path output is /home/node/app/build

#Run Phase
FROM nginx
#Map port in production environment. Only work in Production
EXPOSE 80
#Copy build folder from build phase to nginx
COPY --from=builder /home/node/app/build /usr/share/nginx/html
#The nginx will be start automatically after starting container
