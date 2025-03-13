FROM node:lts-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
RUN npm update
COPY . .
RUN npm run build
RUN npm test # Dodano uruchamianie testów w etapie buildera

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html