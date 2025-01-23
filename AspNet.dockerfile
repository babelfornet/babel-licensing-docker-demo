FROM mcr.microsoft.com/dotnet/aspnet:8.0 as runtime

# Expose service ports
EXPOSE 5005
EXPOSE 5455

# Set working directory
WORKDIR /var/www/babel-lic

# Set entrypoint
ENTRYPOINT [ "dotnet", "Babel.Licensing.Service.dll" ]