# Start from the latest Ubuntu LTS image
FROM ubuntu:22.04 as ubuntu-lts

# Add image metadata
LABEL maintainer="babelfor.net"
LABEL name="babel-licensing-service-net8"
LABEL version="11.0.0"
LABEL description="Babel Licensing Servaice 11.0 with .NET 8.0 and MariaDB"

# Set the environment variable DEBIAN_FRONTEND to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Update Ubuntu Software repository
RUN apt-get update

# Install unzip, Apache, PHP, and other necessary packages
RUN apt-get install -y unzip apache2 php libapache2-mod-php php-mysql mariadb-server wget php-curl php-mbstring

# Download WordPress
RUN wget https://wordpress.org/wordpress-6.7.1.tar.gz && \
    tar -xvzf wordpress-6.7.1.tar.gz && \
    rm -rf /var/www/html/* && \
    mv wordpress/* /var/www/html && \
    rm -rf wordpress

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Change the ownership of the WordPress files to the Apache user
RUN chown -R www-data:www-data /var/www/html

# Install WooCommerce plugin
RUN wget https://downloads.wordpress.org/plugin/woocommerce.latest-stable.zip && \
    unzip woocommerce.latest-stable.zip -d /var/www/html/wp-content/plugins/ && \
    rm woocommerce.latest-stable.zip

# Unzip uploads.zip to the WordPress uploads directory
COPY uploads.zip /tmp/
RUN unzip /tmp/uploads.zip -d /var/www/html/wp-content/ && \
    rm /tmp/uploads.zip

# Install custom Babel Licensing plugin
COPY babel-licensing.zip /tmp/
RUN unzip /tmp/babel-licensing.zip -d /var/www/html/wp-content/plugins/ && \
    rm /tmp/babel-licensing.zip

# Change the ownership of the WordPress files to the Apache user
RUN chown -R www-data:www-data /var/www/html

# Copy wp-config.php to the WordPress directory
COPY wp-config.php /var/www/html/wp-config.php

# Configure Apache to log to stdout and stderr
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# Expose port 80 for the Apache server
EXPOSE 80

# Start Apache service
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]