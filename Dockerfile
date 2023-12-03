#we are creating our own image, for the application
FROM ubuntu:latest
#FROM - to specify base image which can be pulled from a container reg
#RUN - executed commands during image build process
#EXPOSE - Specifies the port to be exposed for the docker container

#update all packages on ubuntu machine
RUN apt-get update
#nginx is web server
RUN apt-get install -y nginx zip curl

RUN echo "daemon off;" >>/etc/nginx/nginx.conf
# curl the repo to this path, the project will be cloned
RUN curl -o /var/www/html/master.zip -L https://github.com/gabrielecirulli/2048/archive/refs/heads/master.zip
#now we have to unzip the master.zip where the repo is cloned
# unzip then move(mv) to current path
RUN cd /var/www/html/ && unzip master.zip && mv 2048-master/* . && rm -rf 2048-master master.zip

#we will host a website so http, to specify the port 

EXPOSE 80

#CMD - specifies the command to be executed when the container is run
#-c specifies the path to the configuration file.
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]

#using this file we will create an image, using image we willm create a container

#to build we use    docker build -t <image-name> .  //-t is used to give name // . means create a image out of docker file which is on current directory4
# instead of . we can give exact path