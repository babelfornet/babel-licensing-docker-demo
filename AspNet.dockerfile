FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime

# Add image metadata
LABEL maintainer="babelfor.net"
LABEL name="babel-licensing-service-net8"
LABEL version="11.0.0"
LABEL description="Babel Licensing Servaice 11.0 (.NET 8.0)"

# Update Ubuntu Software repository
RUN apt-get update

# Install unzip
RUN apt-get install -y unzip 

# Unzip babel_service_net80_11.0.0.0.zip to the /var/www/babel-lic directory
COPY babel_service_net80_11.0.0.0.zip /tmp/
RUN mkdir -p /var/www/babel-lic && \
    unzip /tmp/babel_service_net80_11.0.0.0.zip -d /var/www/babel-lic && \
    rm /tmp/babel_service_net80_11.0.0.0.zip

# Expose service ports
EXPOSE 5005
EXPOSE 5455

# Set working directory
WORKDIR /var/www/babel-lic

# Set entrypoint
ENTRYPOINT [ "dotnet", "Babel.Licensing.Service.dll" ]