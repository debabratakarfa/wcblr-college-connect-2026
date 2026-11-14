# 1. Set up the demo site

The fastest route is `bash scripts/setup.sh`. This page shows what it does, step by step, so you can follow along or build the site by hand.

## Prerequisites

- [DDEV](https://ddev.com/get-started/) v1.24.4 or later (`ddev version`)
- A Docker-compatible runtime: Docker Desktop, OrbStack, Colima or Rancher Desktop

## Create the site

```bash
mkdir site && cd site
ddev config --project-type=wordpress --project-name=wcblr-demo
ddev start
ddev wp core download
ddev wp core install --url='https://wcblr-demo.ddev.site' --title='College Connect Demo' \
  --admin_user=admin --admin_password=admin --admin_email=admin@example.com --skip-email
ddev wp rewrite structure '/%postname%/'
ddev wp rewrite flush
```

## Add demo content and plugins

```bash
ddev wp post create --post_type=page --post_title='Register' --post_name=register --post_status=publish
ddev wp post generate --count=25          # gives the related-posts query real data
ddev wp plugin install contact-form-7 --activate
```

## Install the demo mu-plugin

`mu-plugins/wcblr-demo-slow-cta.php` appends a "Keep reading" CTA to single posts. It builds that CTA with a deliberate N+1 loop: 200 uncached database queries on every page load. You will find it with XHGui in step 5. Add `?fast=1` to the URL to get the cached version.

```bash
mkdir -p wp-content/mu-plugins
cp ../mu-plugins/wcblr-demo-slow-cta.php wp-content/mu-plugins/
```

Never copy this plugin to a real site.

## Turn on private debug logging

```bash
ddev wp config set WP_DEBUG true --raw
ddev wp config set WP_DEBUG_LOG true --raw
ddev wp config set WP_DEBUG_DISPLAY false --raw
ddev wp eval 'var_dump( WP_DEBUG_LOG, WP_DEBUG_DISPLAY );'   # expect bool(true) bool(false)
```

## Switch DDEV to XHGui mode (once per machine)

```bash
ddev config global --xhprof-mode=xhgui && ddev restart
```

## Check it works

- [ ] https://wcblr-demo.ddev.site/ loads
- [ ] https://wcblr-demo.ddev.site/hello-world/ shows a "Keep reading" box with a button
- [ ] `ddev mailpit` opens the Mailpit inbox
- [ ] `ddev xhgui launch` opens XHGui

Next: [2. Add a call to action](02-call-to-action.md)
