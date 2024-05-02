#FROM jenkins/jenkins:2.440.3-jdk17
#USER root
#RUN apt-get update && apt-get install -y lsb-release
#RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
#  https://download.docker.com/linux/debian/gpg
#RUN echo "deb [arch=$(dpkg --print-architecture) \
#  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
#  https://download.docker.com/linux/debian \
#  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
#RUN apt-get update && apt-get install -y docker-ce-cli
#USER jenkins
#RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
#It will use node:19-alpine3.16 as the parent image for 
#building the Docker image
FROM node:19-alpine3.16
#It will create a working directory for Docker. The Docker
#image will be created in this working directory.
WORKDIR /react-app
#Copy the React.js application dependencies from the 
#package.json to the react-app working directory.
COPY package.json .
COPY package-lock.json .
#install all the React.js application dependencies
RUN npm i
<!-- Copy the remaining React.js application folders and files from 
 the `jenkins-kubernetes-deployment` local folder to the Docker 
react-app working directory -->
COPY . .
#Expose the React.js application container on port 3000
EXPOSE 3000
#The command to start the React.js application container
CMD ["npm", "start"]
