#! /bin/bash

# USAGE:
# $1 host
# $2 name
# $3 description
# $4 owner
#
# ./create_project_with_template.sh localhost hadroncollider, "Accelerating particles then smashing them together", "cern"

curl -H 'Content-Type: application/json' \
     -X PUT \
     -d '{"name": "'"$2"'", "description": "'"$3"'", "owner": "'"$4"'", "template": ["artifact", "code_review", "integration_test", "security_scan"]}' \
    $1/api/v1/projects/$4/
