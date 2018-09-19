yastasoti
=========

Yet another script to archive stuff off teh internets.

Was split off from Feedmark, which doesn't itself need to support this function.

### Features ###

*   input is a JSON list of objects containing links (such as those produced by Feedmark)
*   output is a JSON list of objects that could not be retrieved, which can be fed back
    into the script as input
*   checks links with `HEAD` requests by default.  `--archive-to` causes each link to be
    fetched with `GET` and saved to the specified directory.  `--archive-via` specifies an
    _archive router_ which causes each link to be fetched, and saved to a directory
    which is selected based on the URL of the link.
*   tries to be idempotent and not create a new local file if the remote file hasn't changed
*   handles links that are local files; checks if the file exists locally

#### Archive routers ####

An archive router (used with `--archive-via`) is a JSON file that looks like this:

    {
        "http://catseye.tc/*": "/dev/null",
        "https://footu.be/*": "footube/",
        "*": "archive/"
    }

Three guesses as to what these parts mean.

#### Planned features ####

*   Archive youtube links with youtube-dl.
*   Handle failures (redirects, etc) better (detect 503 / "connection refused" better.)
*   Allow use of an external tool like `wget` or `curl` to do fetching.
*   If the same link occurs more than once in the input, don't request it more than once.

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

Tested under Python 2.7.12.  Seems to work under Python 3.5.2 as well,
at least the link-checking parts.

Requires `requests` Python library to make network requests.  Tested
with version 2.17.3.

If `tqdm` Python library is installed, will display a nice progress bar.
