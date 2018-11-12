FROM node:alpine as builder

WORKDIR '/app'

COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# phase 2 of the build process, 1st phase started with FROM 
# command. biuilder is the name of the phase 1 and we extract
# the build directory from there and use it in phase 2 of build
FROM nginx
# /usr/share/nginx/html is the default directory that nginx looks into
# we don't need to make any changes to the config if we can 
# put the stuff there and the content is just static
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html



