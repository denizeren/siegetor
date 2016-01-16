FROM ubuntu

### UPDATE
RUN apt-get update

### TOR Stuff
RUN apt-get install -y tor

### PRIVOXY Stuff
RUN apt-get install -y privoxy
RUN echo "forward-socks5   /               127.0.0.1:9050 ." >> /etc/privoxy/config
RUN sed -i 's@^listen-address  localhost:8118@listen-address  127.0.0.1:8118@' /etc/privoxy/config

### SIEGE Stuff
RUN apt-get install -y siege
RUN echo "proxy-host = 127.0.0.1" >> /etc/siege/siegerc
RUN echo "proxy-port = 8118" >> /etc/siege/siegerc
