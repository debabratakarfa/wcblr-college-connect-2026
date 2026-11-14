# 6. Troubleshooting and FAQ

## Troubleshooting

| Problem | Fix |
| --- | --- |
| `ddev start` fails | Make sure your Docker runtime is running, then `ddev poweroff && ddev start`. |
| No email in Mailpit | Submit the form again and check `ddev logs` for PHP errors. Confirm the form's **Mail** tab has a valid "To" address. |
| XHGui shows no runs | Run `ddev xhgui on` first, then load the page again. Only new requests are captured. |
| `/hello-world/` is not slower than `?fast=1` | Check the mu-plugin is in `site/wp-content/mu-plugins/`. Compare the numbers in XHGui rather than how it feels. |
| `debug.log` is empty | Run `ddev wp eval 'var_dump( WP_DEBUG_LOG );'`. It should print `bool(true)`. |
| Want a clean start | `bash scripts/reset.sh`, then `bash scripts/setup.sh`. |

## FAQ

**Can I run XHGui on my live site?**
Not recommended. It needs a PHP extension and adds overhead to every request. Profile a local or staging copy.

**XHProf or Xdebug?**
Use Xdebug for step debugging. Use XHProf with XHGui for a browsable history of runs and side-by-side comparisons.

**Is there something lighter inside wp-admin?**
[Query Monitor](https://wordpress.org/plugins/query-monitor/) shows queries, hooks and HTTP calls for each page with no extra setup.

**Which form plugin should I use?**
Contact Form 7 is free and simple. Choose another when you need stored entries, payments or conditional logic.

**Why do form emails fail on real hosting?**
Many hosts restrict PHP mail. Use an SMTP plugin with a transactional email service and set up SPF and DKIM for your domain.

**Do I need Docker?**
DDEV needs a Docker-compatible runtime: Docker Desktop, OrbStack, Colima or Rancher Desktop.
