FROM node:lts-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
RUN npm update
COPY . .
RUN npm run build
RUN npm test -- --watchAll=false 
#Dodano opcję, aby testy nie uruchamiały się w trybie watch