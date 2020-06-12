#Build Phase
#-----------------------------

#We can tag this FROM command and everything underneath it as builder
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install

#In the build phase we don't have to use volumes, just copy everything over.
COPY . .
RUN npm run build

#Run Phase
#-----------------------------

#Just saying FROM specifies the start of a second phase. Each block has one FROM statement.
FROM nginx

#copy something from a different phase
COPY --from=builder /app/build:/usr/share/nginx/html

#nginx doesn't need a start command.
#the default command specified by the base image automatically starts the server
#it also serves everything in the /usr/share/nginx/html directory
