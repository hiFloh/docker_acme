FROM debian:stable-slim

COPY ./ /start/
RUN apt-get update
RUN apt-get install -y letsencrypt
RUN apt-get clean \\ && rm -rf /var/lib/apt/lists/*
#RUN mkdir -p /etc/letsencrypt/live/my.example.org
#RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \\
#        -keyout /etc/letsencrypt/live/my.example.org/privkey.pem \\
#        -out /etc/letsencrypt/live/my.example.org/fullchain.pem \\
#        -subj /CN=my.example.o
CMD bash -x /start/run.sh
