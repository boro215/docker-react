FROM node:lts-alpine as builder

WORKDIR 'usr/src/app'

COPY package.json ./
RUN npm install

COPY . .

EXPOSE 4000

RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
