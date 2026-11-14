#!/usr/bin/env bash
# Builds the local WordPress demo site for the College Connect session.
# Safe to run more than once: each step checks before it changes anything.
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SITE_DIR="${REPO_ROOT}/site"
PROJECT="${DDEV_PROJECT:-wcblr-demo}"
URL="https://${PROJECT}.ddev.site"

step() { printf '\n\033[1;34m==> %s\033[0m\n' "$1"; }

if ! command -v ddev >/dev/null 2>&1; then
  echo "DDEV is not installed. Install it from https://ddev.com/get-started/ and run this again." >&2
  exit 1
fi

step "Creating the DDEV project in ${SITE_DIR}"
mkdir -p "${SITE_DIR}"
cd "${SITE_DIR}"
if [ ! -f .ddev/config.yaml ]; then
  ddev config --project-type=wordpress --project-name="${PROJECT}"
fi
ddev start

step "Installing WordPress"
if [ ! -f wp-includes/version.php ]; then
  ddev wp core download
fi
if ! ddev wp core is-installed >/dev/null 2>&1; then
  ddev wp core install --url="${URL}" --title="College Connect Demo" \
    --admin_user=admin --admin_password=admin --admin_email=admin@example.com --skip-email
fi
ddev wp rewrite structure '/%postname%/'
ddev wp rewrite flush

step "Adding demo content"
if [ -z "$(ddev wp post list --post_type=page --name=register --format=ids)" ]; then
  ddev wp post create --post_type=page --post_title='Register' --post_name=register --post_status=publish
fi
if [ "$(ddev wp post list --post_type=post --format=count)" -lt 20 ]; then
  ddev wp post generate --count=25
fi

step "Installing Contact Form 7"
ddev wp plugin is-installed contact-form-7 || ddev wp plugin install contact-form-7
ddev wp plugin activate contact-form-7

step "Installing the demo mu-plugin"
mkdir -p wp-content/mu-plugins
cp "${REPO_ROOT}/mu-plugins/wcblr-demo-slow-cta.php" wp-content/mu-plugins/

step "Turning on private debug logging"
ddev wp config set WP_DEBUG true --raw
ddev wp config set WP_DEBUG_LOG true --raw
ddev wp config set WP_DEBUG_DISPLAY false --raw

cat <<EOF

Done. Your demo site is ready.

  Site:      ${URL}
  Admin:     ${URL}/wp-admin/   (admin / admin, local only)
  Mail:      ddev mailpit
  Slow page: ${URL}/hello-world/
  Fast page: ${URL}/hello-world/?fast=1

Next: docs/02-call-to-action.md
For profiling, run once:  ddev config global --xhprof-mode=xhgui && ddev restart
EOF
