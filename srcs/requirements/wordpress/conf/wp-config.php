<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * Localized language
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'cmero' );

/** Database password */
define( 'DB_PASSWORD', 'db_cmero_pass' );

/** Database hostname */
define( 'DB_HOST', 'mariadb' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',          'pq5GZa;&_0S:|/mHc`v56xoJ`eSd=YjRQKtYmT,dESqIGj+7:x>dkSa7(Uw|^-Lz' );
define( 'SECURE_AUTH_KEY',   'XsXG&b%aM9w7e8W&cP+{M 9U&el7_j$W[@!-r~6f4EP]:4)R))V[zF-w`(<RbON8' );
define( 'LOGGED_IN_KEY',     '%Wx$nb V#NCv=:/~k|C hl)hNlM4XV}Tu[M-+T@En3?uJuO{>=ML0H*e7/GxdQl,' );
define( 'NONCE_KEY',         '[Ry5=ZN7SP-h +Ihp[j?Dz{=O8D/6M$Vy}FVE5^,`S5[J;i)Onz:XfH|5cle17MU' );
define( 'AUTH_SALT',         ':_TpD:R_r=0!< jV,Z82F,7QO<Wy[;AXic`J6vq2<<+tRG{kWh{;0o*SLgvB{NLw' );
define( 'SECURE_AUTH_SALT',  'n$3VQ3L>- )I5XR&_q=[cN:iWD3t)O~4k]!jlBKk$?QR+rAl_-oN0)0n!!rcsNuH' );
define( 'LOGGED_IN_SALT',    'WIku~4ML5P0:HqThn*p228{KE=FM<gd#hGH{|wE]4viK~mUH=#<03UG ;L_`pRU{' );
define( 'NONCE_SALT',        '[M}nfj{b(Tlo1>%ckDp%WN4VV!n_;d %^Qt9XqIa|`+M!TG<UUwFadpBSq7a};$W' );
define( 'WP_CACHE_KEY_SALT', '^Z+zYZ#.B8DR:2|zLuW1qG:m(FF<Qp*_-Y+}#5hzeLRXsvTl./MZH>/2[yP$C8lG' );


/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );


/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );
define( 'WP_REDIS_TIMEOUT', 1 );
define( 'WP_REDIS_READ_TIMEOUT', 1 );
define( 'WP_REDIS_DATABASE', 0 );

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
