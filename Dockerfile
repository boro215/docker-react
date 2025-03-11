FROM node:lts-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install 
RUN npm update --dev
# Copy the package.json file first to install the dependencies
# This is done to avoid re-installing the dependencies when the source code changes
# Copy the rest of the files
COPY . .
RUN npm run build

FROM nginx
# Elastic Beanstalk will automatically map the port 80 to the container
# so we don't need to specify the port here
EXPOSE 80
# Copy the build folder from the builder phase to the nginx folder
# The nginx image will automatically start the nginx server
COPY --from=builder /app/build /usr/share/nginx/html
