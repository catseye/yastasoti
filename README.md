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

*   Archive youtube links with youtube-dl.
*   Handle failures (redirects, etc) better (detect 503 / "connection refused" better.)
*   Allow use of an external tool like `wget` or `curl` to do fetching.
*   Allow categorization of downloaded stuff.

### Examples ###

Check that the links in a set of Feedmark documents all resolve:

    feedmark --output-links article/*.md | yastasoti --article-root=article/ - | tee results.json

Since `--archive-to` was not specified, this will make only `HEAD`
requests to check that the resources exist.  It will not fetch them.

Archive stuff off teh internets:

    cat >links.json << EOF
    [
        {
            "url": "http://catseye.tc/"
        }
    ]
    EOF
    yastasoti --archive-to=downloads links.json

### Requirements ###

Python 2.7 for sure, Python 3.x not sure, will need to run some tests.

Requires `requests` Python library to make network requests.

If `tqdm` Python library is installed, will display a nice progress bar.
