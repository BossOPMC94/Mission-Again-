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

# Expose port 80 for HTTP traffic
EXPOSE 80

# Set root as default user
USER root

# Start tmate in the foreground and nginx as the web server
CMD ["sh", "-c", "tmate -F & nginx -g 'daemon off;'"]
