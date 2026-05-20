# Notes for Claude

## SVN must be reachable over HTTP

The SVN container must expose the repositories over HTTP (`http://127.0.0.1/svn/dist/...`)
via Apache + `mod_dav_svn`, in addition to `svn://` via `svnserve`.

Apache release tooling (e.g. Calcite's `./gradlew prepareVote`, `svnmucc`) talks to the
staging repository over HTTP DAV. A pure `svnserve`-only image breaks the released
flows, so any future base image bump must keep `mod_dav_svn` available on port 80.

Background: previously the image was switched to `garethflowers/svn-server`, which only
ships `svnserve`. That made `http://127.0.0.1/svn/dist` unreachable and broke
`stageSvnDist`/`prepareVote`. See issue
https://github.com/vlsi/asflike-release-environment/issues/3.
