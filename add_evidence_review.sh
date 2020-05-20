#! /bin/bash

# USAGE:
# $1 host
# $2 organization
# $3 project
# $4 sha
# $5 state [APPROVED|PENDING|CHANGES_REQUESTED|DISMISSED]
# $6 description

#
# ./add_evidence_review.sh $host cern hadroncollider '084c799cd551dd1d8d5c5f9a5d593b2e931f5e36122ee5c793c1d08a19839cc0' APPROVED "Description of code review evidence from Build X"


curl -H 'Content-Type: application/json' \
     -X PUT \
     -d '{"evidence_type": "code_review", "contents": {"is_compliant": "true", "url": "https://www.github.com/meekrosoft/gradle-pipeline-example/pull/1", "state": "'"$5"'", "description": "Adding evidence: '"$6"'"}}' \
    $1/api/v1/projects/$2/$3/artifacts/$4

