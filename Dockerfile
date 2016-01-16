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

# SSH Stuff
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:deniz' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22


### START
CMD ["/usr/sbin/sshd", "-D"]
CMD ["/etc/init.d/tor", "start"]
CMD ["/etc/init.d/privoxy", "start"]
