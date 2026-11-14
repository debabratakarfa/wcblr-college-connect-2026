# 4. Debug safely (minutes 68 to 71)

Work through these in order. Most bugs are found by step 3.

## 1. Reproduce

Never debug on a live site. Use a local or staging copy, and write down the exact URL, what you did and what you saw.

## 2. Isolate

- Re-save **Settings, Permalinks** and check **Settings, General** for the right site URL.
- Switch to a default theme, then disable plugins one at a time until the problem goes away.
- The [Health Check and Troubleshooting](https://wordpress.org/plugins/health-check/) plugin does this for your session only, without affecting visitors.

## 3. Inspect the browser

Open DevTools on the page with the problem:

- **Console**: JavaScript errors
- **Network**: failed (red) or slow requests
- **Device toolbar**: layout at mobile widths

## 4. Log privately

`setup.sh` already turned on `WP_DEBUG_LOG` and turned off `WP_DEBUG_DISPLAY`, so errors go to a file instead of the screen. Try it:

```bash
cd site
ddev wp eval 'trigger_error( "Demo: something went wrong", E_USER_NOTICE );'
ddev exec tail -n 3 wp-content/debug.log
```

Logs can contain file paths and personal data. Keep them on local or staging sites, never display errors to visitors, and never commit a `debug.log`.

## 5. Measure

When the site works but is slow, guessing wastes hours. Continue to [5. Measure with XHProf and XHGui](05-profiling-xhgui.md).
