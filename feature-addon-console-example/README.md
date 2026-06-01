# feature-addon-console-example

A console application that shows how to build a **modular / add-on licensing**
model with Babel Licensing, plus how to anchor the **support/maintenance period
to the first activation date**.

It answers two questions that come up a lot:

1. **Can a reseller sell a standalone "feature add-on" license that extends an
   existing base license, without re-issuing the base one?** — Yes.
2. **Can the support period start counting from first activation instead of from
   a fixed issue date?** — Yes.

## 1) Modular add-on licenses (base + reseller add-on)

You are **not limited to a single license**. Each licensed component is
identified by its own .NET `Type` and validated with its **own activation key**,
so an application can hold several independent licenses at the same time:

| Component (`Type`)             | License            | Activation key |
|--------------------------------|--------------------|----------------|
| `BaseApplication`              | base license       | key #1         |
| `AdvancedReportingModule`      | add-on license     | key #2         |

```csharp
// One call per component — each with its own activation key.
var baseLicense  = await EnsureLicensed(client, baseKey,  typeof(BaseApplication));
var addonLicense = await EnsureLicensed(client, addonKey, typeof(AdvancedReportingModule));

// The add-on unlocks an extra feature, and is only honored when the base is valid.
bool advancedReporting = addonLicense.Features.Any(f => f.Name == "AdvancedReporting");
```

Where `EnsureLicensed` validates the key for that component and activates it the
first time:

```csharp
try   { return (await client.ValidateLicenseAsync(userKey, type)).License; }
catch (Babel.Licensing.Service.ServiceException)
{
    await client.ActivateLicenseAsync(userKey, type);
    return (await client.ValidateLicenseAsync(userKey, type)).License;
}
```

Both licenses live in the **same Babel Licensing database**, so they are created
and managed from the single WordPress / Web Application interface — the reseller
simply sells another Licensed Product / SKU that issues the add-on license. The
**base license is never re-issued or modified**: the add-on is a brand-new,
independent license that carries the extra capability in its native `Features`
collection (each feature can also hold binary `Data` and its own `expireDate`).

> **Why validate per key instead of `RegisterLicenseProvider` + `IsLicensed`?**
> A single `BabelServiceLicenseProvider` (one `ClientId`) tracks **one** license
> at a time, so two providers sharing the same `ClientId` would collide. To hold
> several licenses you either validate each one by its key as shown here, or give
> each component its own `ClientId` (separate provider/cache) if you want offline
> caching per component.

## 2) Support period from first activation

A license already has a native **Support Expire Date**, but it is a *fixed* date
set at issue time. To make the support window start from activation instead,
store the duration on the license as a custom **Field** (`SupportDays = 365`) and
compute the end date from the first activation date:

```csharp
int supportDays = int.Parse(license.Fields.First(f => f.Name == "SupportDays").Value);
DateTime supportEnds = firstActivationDate.AddDays(supportDays);
```

This example records the first activation date locally for simplicity. In
production you would instead read the activation date from the server (the
activation token timestamp), or have the service write
`supportExpireDate = activationDate + duration` back to the license through an
activation webhook + the Management API — no extra database needed.

## Create the two demo licenses

The service must be running (see the main [README](../README.md)). From the repo root:

```bash
API=api_u3o7i1au2wycki8awj1kdmp8
BASE=https://localhost:5455

# Base license (activation mode) — copy the returned userKey as key #1
curl -sk -X POST "$BASE/v1/licenses" -H "x-api-key: $API" -H "Content-Type: application/json" \
  -d '{"license":{"templateId":1,"licensingMode":1,"licenseeName":"Add-on Demo","licenseeEmail":"addon@demo.local","licenseeCompany":"Demo Co","maxAllowedSites":1}}'

# Add-on license (activation mode) — carries the AdvancedReporting feature and a
# 365-day support window; copy the returned userKey as key #2
curl -sk -X POST "$BASE/v1/licenses" -H "x-api-key: $API" -H "Content-Type: application/json" \
  -d '{"license":{"templateId":1,"licensingMode":1,"licenseeName":"Add-on Demo","licenseeEmail":"addon@demo.local","licenseeCompany":"Demo Co","maxAllowedSites":1,"features":[{"name":"AdvancedReporting"}],"fields":[{"name":"SupportDays","value":"365"}]}}'
```

> The list endpoint does not expand `features`/`fields`, but they are embedded in
> the signed license the client receives. In a real shop these two licenses would
> be two WooCommerce products / Babel license templates; the reseller sells the
> add-on product and the base license stays untouched.

## Run

```bash
cd feature-addon-console-example
dotnet run
```

When prompted, paste key #1 (base) and then key #2 (add-on). Leave the add-on key
empty to see the application run with the base license only. Expected output with
both keys:

```text
Base license lic... is valid.
Add-on license lic... is valid.
Features unlocked by the add-on:
  - AdvancedReporting
Support window: 365 days from first activation (YYYY-MM-DD).
  Support / updates valid until YYYY-MM-DD (365 day(s) left).

Running the application:
  - core features ............. enabled (base license)
  - advanced reporting ........ ENABLED (add-on license)
```

# Documentation
For more on Babel Licensing features, fields and restrictions, see the
[documentation](https://babelnet.gitbook.io/babel-licensing/).
