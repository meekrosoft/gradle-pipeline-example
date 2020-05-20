#! /bin/bash

# USAGE:
# $1 host
# $2 organization
# $3 project
# $4 sha
# $5 filename
# $6 description
# $7 git_sha
# $8 commit_url
# $9 build_url
#
# ./create_artifact.sh http://server:8001 cern hadroncollider '084c799cd551dd1d8d5c5f9a5d593b2e931f5e36122ee5c793c1d08a19839cc0' accelerator.jar 'My artifact created by build number 1337 on server X' http://jenkins.mycorp.com/bananas/


curl -H 'Content-Type: application/json' \
     -X PUT \
     -d '{"sha256": "'"$4"'", "filename": "'"$5"'", "description": "'"$6"'", "git_commit": "'"$7"'", "commit_url": "'"$8"'", "build_url": "'"$9"'", "is_compliant": "true"}' \
    $1/api/v1/projects/$2/$3/artifacts/
