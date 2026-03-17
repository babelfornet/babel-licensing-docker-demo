# Babel Licensing Docker Demo

The Babel Licensing Docker Demo is a set of files designed to showcase the capabilities of Babel Licensing Service when integrated with a WordPress site.

# Quick Start

This Quick Start guide outlines the essential steps to set up and run the Babel Licensing Docker Demo. For more detailed instructions, please refer to the project [**Wiki**](https://github.com/babelfornet/babel-licensing-docker-demo/wiki) page.

### Prerequisites

To use this demo, ensure you have the following prerequisites, which are included with the purchase of a [Babel Licensing](https://www.babelfor.net/shop/#babel-licensing) edition.

> **Note:** If you have not purchased a Babel Licensing edition, you can request the application files by contacting sales@babelfor.net.

1. Application Files
    - babel_service_datacenter_net90_11.6.0.0.zip
    - babel-licensing.zip
    - Babel.Licensing.11.6.0.nupkg
2. License File (_babel.licenses_) or License Key (e.g. JXYIK-WIMAR-8HTOW-5ULM7)

### Startup

1. Copy application files included license file _babel.licenses_ into this folder. If you received the license key, configure it in the _appsettings.json_ file as shown below:

```
  "Application": {
    ...
    "LicenseKey": "JXYIK-WIMAR-8HTOW-5ULM7",
    ...
```

2. Start Docker Compose

```
docker compose up -d
```

### Services

Once the container is started the following services are avaiable:

- [WordPress Home](http://localhost:8000/)
- [WordPress Admin](http://localhost:8000/wp-admin/) 
    - Username: admin 
    - Password: admin
- [Babel Licensing Web](https://localhost:5455/)
    - Username: admin 
    - Password: admin
- [Babel Licensing Api](https://localhost:5455/swagger/)
    - Authorize ApiKey: api_u3o7i1au2wycki8awj1kdmp8

### .NET Client Examples

Three .NET 9 console examples are included to test the licensing features:

| Example | Description |
|---------|-------------|
| `license-activation-console-example` | Demonstrates license activation and deactivation |
| `floating-license-console-example` | Demonstrates floating license request, validation and release |
| `console-exception-report-example` | Demonstrates exception reporting to the licensing server |

To build and run an example:

```
cd license-activation-console-example
dotnet run
```

The examples connect to the local Docker services via gRPC (`http://localhost:5005`) or HTTPS (`https://localhost:5455`).

You can create test licenses from the [Babel Licensing Web](https://localhost:5455/) dashboard or via the [API](https://localhost:5455/swagger/).

### Shutdown

```
docker compose down
```

Shutdown and delete all volumes (restart from scratch)

```
docker compose down -v
```
