# WordCamp Bengaluru 2026 College Connect: CTA, Forms and Debugging

Companion repo for the 30-minute interaction segment (minutes 50 to 80) led by [Debabrata Karfa](https://bengaluru.wordcamp.org/2026/organizer/debabrata-karfa/).

You will build a call-to-action button, wire a form that really delivers, then debug and profile the site the way professionals do: **reproduce, isolate, inspect, log, measure.**

Everything runs locally on [DDEV](https://ddev.com/). Nothing here should ever touch a live site.

## Agenda

| Minutes | Segment | Guide |
| --- | --- | --- |
| 50 to 58 | Call to action | [02-call-to-action.md](docs/02-call-to-action.md) |
| 58 to 68 | Form | [03-form.md](docs/03-form.md) |
| 68 to 80 | Setup and debugging | [04-debugging.md](docs/04-debugging.md), [05-profiling-xhgui.md](docs/05-profiling-xhgui.md) |

## Quick start

You need DDEV v1.24.4 or later and a Docker-compatible runtime (Docker Desktop, OrbStack, Colima or Rancher Desktop).

```bash
git clone https://github.com/debabratakarfa/wcblr-college-connect-2026.git
cd wcblr-college-connect-2026
./scripts/setup.sh
```

The script builds a WordPress site in `site/` at https://wcblr-demo.ddev.site with:

- a Register page, 25 sample posts and pretty permalinks
- Contact Form 7, active
- the demo mu-plugin from `mu-plugins/` (a deliberately slow CTA for the profiling exercise)
- private debug logging (`WP_DEBUG_LOG` on, `WP_DEBUG_DISPLAY` off)

Log in at https://wcblr-demo.ddev.site/wp-admin/ with `admin` / `admin`. These credentials are for this local site only.

## All steps

1. [Set up the demo site](docs/01-setup.md)
2. [Add a call to action](docs/02-call-to-action.md)
3. [Add a form that delivers](docs/03-form.md)
4. [Debug safely](docs/04-debugging.md)
5. [Measure with XHProf and XHGui](docs/05-profiling-xhgui.md)
6. [Troubleshooting and FAQ](docs/06-troubleshooting-faq.md)

When you are done, `./scripts/reset.sh` deletes the site and its database.

## Repository layout

```
docs/          step-by-step guides, one per segment
mu-plugins/    wcblr-demo-slow-cta.php, the deliberately slow CTA
scripts/       setup.sh builds the site, reset.sh removes it
site/          created by setup.sh (git-ignored)
```

## Further reading

- [Profiling PHP performance with XHProf](https://make.wordpress.org/performance/handbook/measuring-performance/profiling-php-performance-with-xhprof/), WordPress Performance Handbook
- [xhprof profiling](https://docs.ddev.com/en/stable/users/debugging-profiling/xhprof-profiling/), DDEV docs

## License

GPL-2.0-or-later, the same as WordPress. See [LICENSE](LICENSE).
