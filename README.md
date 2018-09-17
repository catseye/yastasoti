yastasoti
=========

Yet another script to archive stuff off teh internets.

Was split off from Feedmark, which doesn't itself need to support this function.

### Features ###

*   input is a JSON list of objects containing links (such as those produced by Feedmark)
*   output is a JSON list of objects that could not be retrieved, which can be fed back
    into the script as input
*   checks links with `HEAD` requests by default; if `--archive-links-to` is given,
    fetches a copy of each resource with `GET` and saves it to disk
*   tries to be idempotent and not create a new local file if the remote file hasn't changed
*   handles links that are local files; checks if the file exists locally

#### Planned features ####

*   archive youtube links with youtube-dl.
*   logging
*   ignore certain URLs
*   Handle failures (redirects, etc) better.  Fall back to external tool like `wget` or `curl`.

### Examples ###

Check that the links in a set of Feedmark documents all resolve:

    feedmark --output-links article/*.md | yastasoti --article-root=article/ - | tee results.json

Since no `--archive-links` options were given, this will make only `HEAD`
requests to check that the resources exist.  It will not fetch them.

Archive stuff off teh internets:

    yastasoti --archive-links-to=downloads links.json

If it is only desired that the links be checked, `--check-links` will
make `HEAD` requests and will not save any of the responses.

Requirements: requests

Optional dependencies: tqdm

TODO: Update this documentation and make it make sense
