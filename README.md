# Babel Licensing Docker Demo

The Babel Licensing Docker Demo is a set of files designed to showcase the capabilities of Babel Licensing Service when integrated with a WordPress site.

# Quick Start

This Quick Start guide outlines the essential steps to set up and run the Babel Licensing Docker Demo. For more detailed instructions, please refer to the project [**Wiki**](https://github.com/babelfornet/babel-licensing-docker-demo/wiki) page.

### Prerequisites

You need:

1. **Docker** with Compose v2 (Docker Desktop on macOS/Windows, or Docker Engine + Compose on Linux).
2. **.NET 9 SDK** to build and run the console examples (`dotnet --version` should be `9.x`).
3. **Babel Licensing application files** — included with the purchase of a [Babel Licensing](https://www.babelfor.net/shop/#babel-licensing) edition. Drop these files into the root of this repository:
    - `babel_service_datacenter_net90_11.7.0.0.zip` — the Babel Licensing Service binaries (consumed by [AspNet.dockerfile](AspNet.dockerfile))
    - `babel-licensing.zip` — the Babel Licensing WordPress plugin (consumed by [WordPress.dockerfile](WordPress.dockerfile))
    - `Babel.Licensing.11.7.0.nupkg` — the .NET client package (consumed by the example projects via the local `nuget.config`)
4. **License File or License Key** — required to start the Babel Licensing Service:
    - `babel.licenses` file — drop it in the repo root, replacing the placeholder; **or**
    - A license key string (e.g. `JXYIK-WIMAR-8HTOW-5ULM7`) configured in [appsettings.json](appsettings.json).

> If you have not purchased a Babel Licensing edition, you can request the demo files and a trial license by contacting **sales@babelfor.net**.

> **None of these files are committed to git.** The repository's [.gitignore](.gitignore) excludes the zip and nupkg artifacts, and `babel.licenses` is shipped as a placeholder text file you must overwrite locally. Do **not** commit your real license file or license key.

### Configure the license

Choose **one** of the following:

- **License file (recommended):** copy your `babel.licenses` over the placeholder file in the repo root. [appsettings.json](appsettings.json) already points at it (`"LicenseFile": "babel.licenses"`).
- **License key:** edit [appsettings.json](appsettings.json) and set the key:

```jsonc
  "Application": {
    ...
    "LicenseFile": "",
    "LicenseKey": "JXYIK-WIMAR-8HTOW-5ULM7",
    ...
```

### Startup

```
docker compose up -d
```

The first run builds the WordPress and Babel Licensing Service images, initializes the MariaDB volume from [licenses.sql](licenses.sql) + [licenses-fix-keys.sql](licenses-fix-keys.sql) + [wordpress.sql](wordpress.sql), and starts all three containers.

> **Port mapping.** [compose.yaml](compose.yaml) publishes WordPress on host port `8001`, MariaDB on `6606`, the Babel Licensing gRPC endpoint on `5005`, and the HTTPS endpoint on `5455`. Edit [compose.yaml](compose.yaml) if any of those collide with services already running on your host.

### Services

Once the containers are up, the following services are available:

- [WordPress Home](http://localhost:8001/)
- [WordPress Admin](http://localhost:8001/wp-admin/)
    - Username: `admin`
    - Password: `admin`
- [Babel Licensing Web](https://localhost:5455/)
    - Username: `admin`
    - Password: `admin`
- [Babel Licensing API (Swagger)](https://localhost:5455/swagger/)
    - Authorize ApiKey: `api_u3o7i1au2wycki8awj1kdmp8`

The HTTPS endpoint uses the self-signed certificate in [HttpKeys.pfx](HttpKeys.pfx) (password `babellicensing`) — your browser will warn the first time; accept the certificate to continue.

### .NET Client Examples

Four .NET 9 console examples are included to exercise the licensing features:

| Example | Description |
|---------|-------------|
| [`license-activation-console-example`](license-activation-console-example/) | Demonstrates license activation, validation, and deactivation |
| [`floating-license-console-example`](floating-license-console-example/) | Demonstrates floating license request, validation, and release |
| [`console-exception-report-example`](console-exception-report-example/) | Demonstrates exception reporting to the licensing server |
| [`feature-addon-console-example`](feature-addon-console-example/) | Demonstrates modular add-on licenses (base + reseller add-on) and an activation-anchored support period |

Each example is a standalone `dotnet` console project that resolves `Babel.Licensing` from the `Babel.Licensing.11.7.0.nupkg` you placed in the repo root (via the local `nuget.config`).

By default the examples connect to the licensing service over HTTPS at `https://localhost:5455` using the `UseHttp(...)` transport with TLS validation disabled (because of the self-signed cert). To switch to gRPC, edit `Program.cs` in the example, change `ServiceUrl` to `http://localhost:5005`, and remove the `UseHttp(...)` block.

#### Create the demo licenses

Before running the examples, create one license per example. You can do this from the [Babel Licensing Web](https://localhost:5455/) dashboard, or via the API. The shell snippet below creates all three at once using the seeded license template:

```bash
API=api_u3o7i1au2wycki8awj1kdmp8
BASE=https://localhost:5455

# Activation license — copy the returned userKey into the activation example
curl -sk -X POST "$BASE/v1/licenses" -H "x-api-key: $API" -H "Content-Type: application/json" \
  -d '{"license":{"templateId":1,"licensingMode":1,"licenseeName":"Activation Demo","licenseeEmail":"activation@demo.local","licenseeCompany":"Demo Co","maxAllowedSites":1}}'

# Floating license — copy the returned userKey into the floating example
curl -sk -X POST "$BASE/v1/licenses" -H "x-api-key: $API" -H "Content-Type: application/json" \
  -d '{"license":{"templateId":1,"licensingMode":2,"licenseeName":"Floating Demo","licenseeEmail":"floating@demo.local","licenseeCompany":"Demo Co","maxAllowedSites":3}}'

# Exception-report license — uses the fixed userKey hard-coded in the example
curl -sk -X POST "$BASE/v1/licenses" -H "x-api-key: $API" -H "Content-Type: application/json" \
  -d '{"license":{"templateId":1,"licensingMode":1,"userKey":"QGA6G-MTATL-2M798-4706W","licenseeName":"Reporting Demo","licenseeEmail":"reporting@demo.local","licenseeCompany":"Demo Co","maxAllowedSites":1}}'

# Feature add-on example — two activation licenses: a base, plus a standalone
# add-on carrying the AdvancedReporting feature and a 365-day support window
curl -sk -X POST "$BASE/v1/licenses" -H "x-api-key: $API" -H "Content-Type: application/json" \
  -d '{"license":{"templateId":1,"licensingMode":1,"licenseeName":"Add-on Demo","licenseeEmail":"addon@demo.local","licenseeCompany":"Demo Co","maxAllowedSites":1}}'
curl -sk -X POST "$BASE/v1/licenses" -H "x-api-key: $API" -H "Content-Type: application/json" \
  -d '{"license":{"templateId":1,"licensingMode":1,"licenseeName":"Add-on Demo","licenseeEmail":"addon@demo.local","licenseeCompany":"Demo Co","maxAllowedSites":1,"features":[{"name":"AdvancedReporting"}],"fields":[{"name":"SupportDays","value":"365"}]}}'
```

`licensingMode`: `1` = activation, `2` = floating. The exception-report example has `UserKey = "QGA6G-MTATL-2M798-4706W"` hard-coded in [Program.cs](console-exception-report-example/Program.cs) — keep that key when creating its license, or change both to a key of your choice.

#### Run an example

```
cd license-activation-console-example
dotnet run
```

When prompted, paste the user key returned by the corresponding `curl` call above. The exception-report example does not prompt; it sends each thrown exception to the licensing service automatically.

You can verify the reports landed via:

```bash
curl -sk -H "x-api-key: $API" "$BASE/v1/reports?take=10"
```

### Shutdown

```
docker compose down
```

Shutdown and delete all volumes (restart from scratch):

```
docker compose down -v
```
