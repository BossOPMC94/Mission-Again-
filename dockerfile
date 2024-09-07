# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    vim \
    git \
    tmate \
    php8.1-cli \
    php8.1-fpm \
    redis-server \
    supervisor \
    nginx \
    net-tools \
    openssh-server \
    openssh-client \
    systemd \
    systemd-sysv \
    dbus \
    dbus-user-session \
    ufw \
    && rm -rf /var/lib/apt/lists/*

# Configure SSH
RUN sed -i 's/^#\?\s*PermitRootLogin\s\+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN echo 'root:root' | chpasswd
RUN printf '#!/bin/sh\nexit 0' > /usr/sbin/policy-rc.d

# Configure firewall
RUN ufw allow 22 && ufw allow 80 && ufw allow 443

# Copy Supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose necessary ports
EXPOSE 80 6379

# Set root as default user
USER root

# Start Supervisor to manage PHP-FPM, Redis, nginx, and tmate
CMD ["/usr/bin/supervisord"]
