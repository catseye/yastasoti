`yastasoti`
===========

_Version 0.4_
| _Entry_ [@ catseye.tc](https://catseye.tc/node/yastasoti)
| _See also:_ [ellsync](https://codeberg.org/catseye/ellsync#ellsync)
∘ [tagfarm](https://codeberg.org/catseye/tagfarm#tagfarm)
∘ [shelf](https://codeberg.org/catseye/shelf#shelf)

- - - -

<img align="right" src="images/yastasoti-logo.png?raw=true" />

Yet another script to archive stuff off teh internets.

It's not a spider that automatically crawls previously undiscovered webpages — it's intended
to be run by a human to make backups of resources they have already seen and recorded the URLs of.

It was split off from [Feedmark][], which doesn't itself need to support this function.

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
*   can log its actions verbosely to a specified logfile
*   source code is a single, public-domain file with a single dependency (`requests`)

### Examples ###

#### Check all links in a set of Feedmark documents ####

    feedmark --output-links article/*.md | yastasoti --extant-path=article/ - | tee results.json

This will make only `HEAD` requests to check that the resources exist.
It will not fetch them.  The ones that could not be fetches will appear
in `results.json`, and you can run yastasoti on that again to re-try:

    yastasoti --extant-path=article/ results.json | tee results2.json

#### Archive stuff off teh internets ####

    cat >links.json << EOF
    [
        {
            "url": "http://catseye.tc/"
        }
    ]
    EOF
    yastasoti --archive-to=downloads links.json

#### Override the filename the stuff is archived as ####

By default, the subdirectory and filename to which the stuff is archived are
based on the site's domain name and the stuff's path.  The filename, however,
can be overridden if the input JSON contains a `dest_filename` field.

    cat >links.json << EOF
    [
        {
            "url": "http://catseye.tc/",
            "dest_filename": "home_page.html"
        }
    ]
    EOF
    yastasoti --archive-to=downloads links.json

#### Categorize archived materials with a router ####

An archive router (used with `--archive-via`) is a JSON file that looks like this:

    {
        "http://catseye.tc/*": "/dev/null",
        "https://footu.be/*": "footube/",
        "*": "archive/"
    }

If a URL matches more than one pattern, the longest pattern will be selected.
If the destination is `/dev/null` it will be treated specially — the file will
not be retrieved at all.  If no pattern matches, an error will be raised.

To use an archive router once it has been written:

    yastasoti --archive-via=router.json links.json

### Requirements ###

Tested under Python 2.7.12.  Seems to work under Python 3.5.2 as well,
but this is not so official.

Requires `requests` Python library to make network requests.  Tested
with `requests` version 2.21.0.

If `tqdm` Python library is installed, will display a nice progress bar.

(Or, if you would like to use Docker, you can pull a Docker image from
[catseye/yastasoti on Docker Hub](https://hub.docker.com/r/catseye/yastasoti),
following the instructions given on that page.)

### TODO ####

*   Archive youtube links with youtube-dl.
*   Handle failures (redirects, etc) better (detect 503 / "connection refused" better.)
*   Allow use of an external tool like `wget` or `curl` to do fetching.

[Feedmark]: http://catseye.tc/node/Feedmark
