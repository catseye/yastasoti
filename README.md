yastasoti
=========

Yet another script to archive stuff off teh internets.

Was split off from Feedmark, which doesn't itself need to support this function.

Features:

*   input is a JSON list of objects containing links (such as those produced by Feedmark)
*   tries to be idempotent and not create a new local file if the remote file hasn't changed
*   planned: archive youtube links with youtube-dl.
*   TODO: logging
*   TODO: Handle redirects (301, 302) better when archiving external links.(?)

Example:
    
    yastasoti --archive-links-to=downloads links.json

If it is only desired that the links be checked, `--check-links` will
make `HEAD` requests and will not save any of the responses.

Requirements: requests

Optional dependencies: tqdm

TODO: Update this documentation and make it make sense
