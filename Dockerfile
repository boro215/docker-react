FROM node:lts-alpine as builder
WORKDIR /app 
#Poprawiona linia
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
#RUN npm test -- --watchAll=false

FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html