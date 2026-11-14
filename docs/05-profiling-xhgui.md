# 5. Measure with XHProf and XHGui (minutes 71 to 80)

Don't guess. Measure, change one thing, measure again.

[XHProf](https://github.com/longxinH/xhprof) records how long every PHP function takes during a request. [XHGui](https://github.com/perftools/xhgui) stores those runs and lets you browse and compare them. DDEV v1.24.4+ ships both.

## Turn it on

Run once per machine:

```bash
ddev config global --xhprof-mode=xhgui && ddev restart
```

Then, from `site/`, each time you want to profile:

```bash
ddev xhgui on        # only requests after this are captured
```

## Find the slow code

1. Load https://wcblr-demo.ddev.site/hello-world/ three times.
2. Run `ddev xhgui launch` and open the newest run for `/hello-world/`.
3. Sort the function table by **exclusive wall time** (time spent in the function itself, not its children).
4. Find `wcblr_demo_build_cta`, then look at the call counts for `WP_Query` and `wpdb::query`. One page load runs hundreds of queries.

That is the **N+1 problem**: one query inside a loop, repeated 200 times. Open `mu-plugins/wcblr-demo-slow-cta.php` to see it.

## Fix it and prove it

1. Load https://wcblr-demo.ddev.site/hello-world/?fast=1 twice. The first request fills a transient cache; the second is your real measurement.
2. In XHGui, open a slow run, choose **Compare**, and pick the fast run.
3. Note the change in wall time and in the number of `wpdb::query` calls.

## Turn it off

```bash
ddev restart         # profiling stays off until you run ddev xhgui on again
```

## Not using DDEV?

The WordPress Performance Handbook covers wp-env and manual setups with the `perftools/php-profiler` library:
[Profiling PHP performance with XHProf](https://make.wordpress.org/performance/handbook/measuring-performance/profiling-php-performance-with-xhprof/)

## Reference

- [DDEV: xhprof profiling](https://docs.ddev.com/en/stable/users/debugging-profiling/xhprof-profiling/)
- [WordPress Performance Handbook: Profiling PHP performance with XHProf](https://make.wordpress.org/performance/handbook/measuring-performance/profiling-php-performance-with-xhprof/)

Next: [6. Troubleshooting and FAQ](06-troubleshooting-faq.md)
