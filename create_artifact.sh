#! /bin/bash

# USAGE:
# $1 organization
# $2 project
# $3 sha
# $4 filename
# $5 description
# $6 git_sha
#
# ./create_artifact.sh cern hadroncollider '084c799cd551dd1d8d5c5f9a5d593b2e931f5e36122ee5c793c1d08a19839cc0' accelerator.jar 'My artifact created by build number 1337 on server X'


curl -H 'Content-Type: application/json' \
     -X PUT \
     -d '{"sha256": "'"$3"'", "filename": "'"$4"'", "description": "'"$5"'", "git_commit": "'"$6"'"}' \
    http://hub/api/projects/$1/$2/artifacts
