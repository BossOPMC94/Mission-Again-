# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    vim \
    git \
    tmate \
    && rm -rf /var/lib/apt/lists/*

# Set root as default user
USER root

# Start tmate session by default
CMD ["tmate"]
