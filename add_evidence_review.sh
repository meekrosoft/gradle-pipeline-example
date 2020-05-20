#! /bin/bash

# USAGE:
# $1 organization
# $2 project
# $3 sha
# $4 state [APPROVED|PENDING|CHANGES_REQUESTED|DISMISSED]
# $5 description

#
# ./add_evidence_review.sh cern hadroncollider '084c799cd551dd1d8d5c5f9a5d593b2e931f5e36122ee5c793c1d08a19839cc0' APPROVED "Description of code review evidence from Build X"


curl -H 'Content-Type: application/json' \
     -X PUT \
     -d '{"evidence_type": "code_review", "contents": {"is_compliant": "true", "url": "https://www.github.com/meekrosoft/gradle-pipeline-example/pull/1", "state": "'"$4"'", "description": "Adding evidence: '"$5"'"}}' \
    http://server/api/v1/projects/$1/$2/artifacts/$3

