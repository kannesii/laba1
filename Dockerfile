FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y imagemagick
COPY script.sh .
RUN chmod +x script.sh
CMD ./script.sh
