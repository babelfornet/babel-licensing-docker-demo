<?php
define('DB_NAME', 'wordpress');
define('DB_USER', 'root');
define('DB_PASSWORD', 'hjWrTSKa12PUoY');
define('DB_HOST', 'db:3306');
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

$table_prefix = 'wp_';

define('WP_DEBUG', false);

# Email Configuration
define('SMTP_HOST', 'smtp.example.com');          // Replace with your SMTP server address
define('SMTP_PORT', 587);                         // SMTP port (e.g., 587 for TLS, 465 for SSL)
define('SMTP_SECURE', 'tls');                     // Security type ('tls' or 'ssl')
define('SMTP_AUTH', true);                        // Enable SMTP authentication
define('SMTP_USER', 'your-email@example.com');    // SMTP username (your email address)
define('SMTP_PASSWORD', 'your-email-password');   // SMTP password
define('SMTP_FROM', 'no-reply@example.com');      // Email address to show in the "From" field
define('SMTP_FROM_NAME', 'Your Store Name');      // Name to display in the "From" field

if ( !defined('ABSPATH') )
    define('ABSPATH', dirname(__FILE__) . '/');

require_once(ABSPATH . 'wp-settings.php');
