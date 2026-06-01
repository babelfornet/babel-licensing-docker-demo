using Babel.Licensing;

// =============================================================================
// Feature add-on (modular) licensing example
// =============================================================================
//
// This example answers two questions:
//
//   1) How can a reseller sell a *standalone* "feature add-on" license that
//      extends an existing *base* license, WITHOUT regenerating the base one,
//      and managed from the SAME single web interface?
//
//   2) How can the support/maintenance window start counting from the FIRST
//      ACTIVATION date instead of from a fixed issue/purchase date?
//
// Key idea for (1): you are NOT limited to a single license. Each licensed
// component is identified by its own .NET Type and validated with its own
// activation key, so you can activate/validate several independent licenses at
// the same time on the same machine:
//
//      typeof(BaseApplication)         -> base license   (key #1)
//      typeof(AdvancedReportingModule) -> add-on license (key #2)
//
// Both licenses live in the SAME Babel Licensing database, so they are created
// and managed from the single WordPress / Web Application interface. The add-on
// is a brand-new, independent license (sold by a reseller as another product /
// SKU) — the base license is never touched or re-issued. The add-on is only
// honored when a valid base license is present (we gate it below).
//
// Key idea for (2): the add-on license carries a "SupportDays" custom Field
// (e.g. 365). The support window is then computed from the date of the FIRST
// successful activation on this machine, so a customer who activates 3 months
// after purchase still gets the full support period.
// =============================================================================

// Marker types that identify each licensed component. They do not need any
// implementation — they are only used as keys to validate a specific license.
class BaseApplication { }
class AdvancedReportingModule { }

internal static class Program
{
    // Public key used to verify the license signature (same demo key as the
    // other examples in this repository).
    const string PublicKey =
        "MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDE1VRiIdr6fiVZKve7NVgjIvGdRiRx0Mjjm+Yz" +
        "f6tLbzFnxLs0fat5EoRcubxx0QQQDfydsJBE/fc7cwRWSrE2xK6X4Eb4W8O47pCMjqvTQZfDqQyw" +
        "EZJrLlxpp9hlKz6FDYX4SagrjmP1gdw8olo+n+IBz8ubkNxRhvycikxuDQIDAQAB";

    // Name of the add-on feature carried by the add-on license.
    const string AddOnFeature = "AdvancedReporting";

    static async Task<int> Main()
    {
        BabelLicensingConfiguration config = new BabelLicensingConfiguration()
        {
            // HTTPS transport used by the v11.7 demo. Switch to the gRPC
            // endpoint (http://localhost:5005) and drop the UseHttp(...) block
            // below to use gRPC instead.
            ServiceUrl = "https://localhost:5455",
            SignatureProvider = RSASignature.FromKeys(PublicKey),
            ClientId = "FeatureAddonApp"
        };

        config.UseHttp(http =>
        {
            http.Timeout = TimeSpan.FromSeconds(30);
            // The demo service uses a self-signed certificate.
            http.Handler = new HttpClientHandler()
            {
                ServerCertificateCustomValidationCallback = (message, cert, chain, errors) => true
            };
        });

        BabelLicensing client = new BabelLicensing(config);

        // ---------------------------------------------------------------------
        // 1) Base license — required for everything else to work.
        // ---------------------------------------------------------------------
        Console.Write("Enter the BASE license activation key: ");
        string? baseKey = Console.ReadLine();

        ILicense baseLicense;
        try
        {
            baseLicense = await EnsureLicensed(client, baseKey, typeof(BaseApplication));
            Console.WriteLine($"Base license {baseLicense.Id} is valid.");
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Base license is not valid: {ex.Message}");
            return 1;
        }

        // ---------------------------------------------------------------------
        // 2) Add-on license — OPTIONAL, sold separately (possibly by a reseller).
        //    It is a standalone license with its own activation key. We only
        //    honor it when the base license above is valid.
        // ---------------------------------------------------------------------
        Console.Write("Enter the ADD-ON license activation key (leave empty to skip): ");
        string? addonKey = Console.ReadLine();

        bool advancedReporting = false;
        if (!string.IsNullOrWhiteSpace(addonKey))
        {
            try
            {
                ILicense addon = await EnsureLicensed(client, addonKey, typeof(AdvancedReportingModule));

                // The add-on is only meaningful together with a valid base
                // license (which is guaranteed valid at this point).
                advancedReporting = HasFeature(addon, AddOnFeature);

                Console.WriteLine($"Add-on license {addon.Id} is valid.");
                Console.WriteLine("Features unlocked by the add-on:");
                foreach (var feature in addon.Features)
                    Console.WriteLine($"  - {feature.Name}");

                // -------------------------------------------------------------
                // Question 2 — support window anchored to the FIRST activation.
                // The add-on license carries a "SupportDays" custom field; the
                // window is computed from the first activation date recorded on
                // this machine, not from the (fixed) issue date.
                // -------------------------------------------------------------
                PrintSupportWindow(addon, typeof(AdvancedReportingModule));
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Add-on license is not valid: {ex.Message}");
            }
        }

        // ---------------------------------------------------------------------
        // Use the licensed features.
        // ---------------------------------------------------------------------
        Console.WriteLine();
        Console.WriteLine("Running the application:");
        Console.WriteLine("  - core features ............. enabled (base license)");
        Console.WriteLine(advancedReporting
            ? "  - advanced reporting ........ ENABLED (add-on license)"
            : "  - advanced reporting ........ locked (buy the add-on to unlock)");

        return 0;
    }

    // Validates the license identified by 'userKey' for the given component
    // 'type'. If the license is not yet activated on this machine, it is
    // activated first and then validated. This is what lets the application
    // hold MORE THAN ONE license at the same time: one call per component, each
    // with its own activation key.
    static async Task<ILicense> EnsureLicensed(BabelLicensing client, string? userKey, Type type)
    {
        if (string.IsNullOrWhiteSpace(userKey))
            throw new ArgumentException("No activation key was provided.");

        try
        {
            // Already activated on this machine — just validate it.
            var result = await client.ValidateLicenseAsync(userKey, type);
            MarkFirstActivation(type);
            return result.License;
        }
        catch (Babel.Licensing.Service.ServiceException)
        {
            // Not activated yet — activate, then validate.
            await client.ActivateLicenseAsync(userKey, type);
            MarkFirstActivation(type);
            var result = await client.ValidateLicenseAsync(userKey, type);
            return result.License;
        }
    }

    // Returns true if the license exposes the named feature.
    static bool HasFeature(ILicense license, string name)
        => license.Features.Any(f => string.Equals(f.Name, name, StringComparison.OrdinalIgnoreCase));

    // Reads a custom Field value, tolerating a missing field.
    static string? GetField(ILicense license, string name)
        => license.Fields
            .FirstOrDefault(f => string.Equals(f.Name, name, StringComparison.OrdinalIgnoreCase))
            ?.Value;

    // Computes and prints the support/maintenance window relative to the first
    // activation date on this machine.
    static void PrintSupportWindow(ILicense license, Type component)
    {
        string? supportDaysValue = GetField(license, "SupportDays");
        if (!int.TryParse(supportDaysValue, out int supportDays))
        {
            Console.WriteLine("  (license has no 'SupportDays' field — support window not computed)");
            return;
        }

        DateTime activated = FirstActivationUtc(component);
        DateTime supportEnd = activated.AddDays(supportDays);
        int daysLeft = (int)Math.Ceiling((supportEnd - DateTime.UtcNow).TotalDays);

        Console.WriteLine($"Support window: {supportDays} days from first activation ({activated:yyyy-MM-dd}).");
        Console.WriteLine(daysLeft >= 0
            ? $"  Support / updates valid until {supportEnd:yyyy-MM-dd} ({daysLeft} day(s) left)."
            : $"  Support / updates expired on {supportEnd:yyyy-MM-dd} ({-daysLeft} day(s) ago).");
    }

    // --- First-activation bookkeeping ----------------------------------------
    // The first time a component is licensed on this machine we persist the UTC
    // timestamp next to the application, so the support window can be anchored
    // to it. In production you would instead read the activation date from the
    // server (the activation token timestamp) or have the service set
    // 'supportExpireDate = activationDate + duration' through a webhook.
    static string MarkerPath(Type component)
        => Path.Combine(AppContext.BaseDirectory, $".first-activation.{component.Name}");

    static void MarkFirstActivation(Type component)
    {
        string path = MarkerPath(component);
        if (!File.Exists(path))
            File.WriteAllText(path, DateTime.UtcNow.ToString("O"));
    }

    static DateTime FirstActivationUtc(Type component)
    {
        string path = MarkerPath(component);
        if (File.Exists(path) &&
            DateTime.TryParse(File.ReadAllText(path), null,
                System.Globalization.DateTimeStyles.RoundtripKind, out DateTime when))
        {
            return when;
        }
        return DateTime.UtcNow;
    }
}
