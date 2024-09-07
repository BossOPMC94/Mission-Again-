# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update and install necessary packages
RUN apt-get update && apt-get install -y && apt install net-tools -y \
    curl \
    sudo \
    vim \
    git \
    tmate \
    nginx \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update
RUN apt-get install -y tmate openssh-server openssh-client
RUN sed -i 's/^#\?\s*PermitRootLogin\s\+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d
RUN apt-get install -y systemd systemd-sysv dbus dbus-user-session
RUN printf "systemctl start systemd-logind" >> /etc/profile
RUN apt install curl -y
RUN apt install ufw -y && ufw allow 80 && ufw allow 443 && apt install net-tools -y


# Expose port 80 for HTTP traffic
EXPOSE 80

# Set root as default user
USER root

# Start tmate in the foreground and nginx as the web server
CMD ["sh", "-c", "tmate -F & nginx -g 'daemon off;'"]
