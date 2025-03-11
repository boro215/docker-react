FROM node:lts-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install 
RUN npm update
# Copy the package.json file first to install the dependencies
# This is done to avoid re-installing the dependencies when the source code changes
# Copy the rest of the files
COPY . .
# Build the project
# The build folder will be created in the /app folder
RUN npm run build

FROM nginx
# Elastic Beanstalk will automatically map the port 80 to the container
# so we don't need to specify the port here
EXPOSE 80
# Copy the build folder from the builder phase to the nginx folder
# The nginx image will automatically start the nginx server
COPY --from=builder /app/build /usr/share/nginx/html

CMD [ "npm", "run", "start" ]
# The nginx image will automatically start the nginx server
