FROM node:lts-alpine as builder
WORKDIR '/usr/src/app'
#Poprawiona linia
COPY package.json .
RUN npm install
COPY . .
RUN npm run build
#RUN npm test -- --watchAll=false

FROM nginx:alpine
EXPOSE 80
COPY --from=builder /usr/src/app /usr/share/nginx/html