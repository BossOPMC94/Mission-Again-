# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04

# Set environment variables to avoid interactive time zone selection
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    vim \
    git \
    tmate \
    nginx \
    php8.1-cli \
    php8.1-fpm \
    redis-server \
    supervisor \
    tzdata \
    && rm -rf /var/lib/apt/lists/* \
    # Ensure necessary directories for logs exist
    && mkdir -p /var/log/nginx /var/log/php-fpm /var/log/redis /var/log/tmate

# Copy the supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose necessary ports
EXPOSE 80 6379

# Set root as default user
USER root

# Start Supervisor to manage PHP-FPM, Redis, nginx, and tmate
CMD ["/usr/bin/supervisord"]
