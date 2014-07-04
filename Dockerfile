# Namely Demo Nginx Dockerfile
#
# docker run -dit \
#   -p 80:80 \
#   -p 443:443 \
#   --name demo.nginx \
#   namely/demo-nginx

FROM amos6224/namely.3

# Install Nginx.
RUN apt-get -qy update
RUN apt-get -qy install nginx

# Add our configuration files
ADD nginx.conf /etc/nginx/nginx.conf
ADD mime.types /etc/nginx/mime.types
ADD auth /etc/nginx/auth
RUN chown -Rf root:root /etc/nginx

# Create the demo log dir
RUN mkdir -p /var/log/nginx/demo

# Remove the default site
RUN rm -f /etc/nginx/sites-enabled/default

# Allow attaching to sites-available and log directory
VOLUME ["/etc/nginx/sites-enabled", "/var/log/nginx"]

# Set working directory.
WORKDIR /etc/nginx

# Expose ports
EXPOSE 80
EXPOSE 443

# Define default command.
CMD ["nginx"]
