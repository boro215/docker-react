# Etap 1: Budowanie aplikacji React
FROM node:lts-alpine as builder
WORKDIR /app
COPY package*.json ./
RUN npm install --force
COPY . .
RUN npm run build
#RUN npm test --watchAll=false

# Etap 2: Serwowanie aplikacji za pomocą Nginx
FROM nginx:alpine
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
