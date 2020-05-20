#! /bin/bash

# USAGE:
# $1 organization
# $2 project
# $3 sha
# $4 evidence_type
# $5 description

#
# ./add_evidence.sh cern hadroncollider '084c799cd551dd1d8d5c5f9a5d593b2e931f5e36122ee5c793c1d08a19839cc0' security_scan "Adding integration test information"


curl -H 'Content-Type: application/json' \
     -X PUT \
     -d '{"evidence_type": "'"$4"'", "contents": {"is_compliant": "true", "security_result": "No vulnerabilities found.", "description": "Adding evidence: '"$5"'"}}' \
    http://server/api/v1/projects/$1/$2/artifacts/$3

