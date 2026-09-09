#!/usr/bin/env bash
#
# Define and assign GitHub organization custom properties for this repository.
#
# Custom properties are an ORGANIZATION-level feature. Defining the schema and
# assigning values both require a token with:
#   Organization permissions -> "Custom properties" -> Read and write
# A repository-scoped token is NOT sufficient.
#
# This script never stores the token. Pass it via the GH_TOKEN environment
# variable so it is not written to disk or shell history files.
#
# Usage:
#   GH_TOKEN=xxxxx ./tools/setup_custom_properties.sh
#
set -euo pipefail

ORG="runtoolkit"
REPO="TunnelScript"
API="https://api.github.com"

: "${GH_TOKEN:?Set GH_TOKEN to a token with org custom-properties write access}"

auth=(-H "Authorization: Bearer ${GH_TOKEN}" -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28")

echo "==> Defining property schemas on org '${ORG}'"

# mc_version: target Minecraft version(s)
curl -sf -X PUT "${auth[@]}" "${API}/orgs/${ORG}/properties/schema/mc_version" -d '{
  "value_type": "single_select",
  "required": false,
  "description": "Target Minecraft version",
  "allowed_values": ["1.20.4", "1.21.1", "1.21.4"]
}' >/dev/null && echo "    mc_version defined"

# status: project status
curl -sf -X PUT "${auth[@]}" "${API}/orgs/${ORG}/properties/schema/status" -d '{
  "value_type": "single_select",
  "required": false,
  "description": "Project status",
  "allowed_values": ["active", "maintenance", "deprecated", "archived"]
}' >/dev/null && echo "    status defined"

# type: project type
curl -sf -X PUT "${auth[@]}" "${API}/orgs/${ORG}/properties/schema/type" -d '{
  "value_type": "single_select",
  "required": false,
  "description": "Project type",
  "allowed_values": ["library", "application", "tool", "template"]
}' >/dev/null && echo "    type defined"

echo "==> Assigning values to '${ORG}/${REPO}'"
# Note: a single_select value must be one allowed value. The repo's default
# branch (main) targets 1.21.1, so mc_version is set accordingly here.
curl -sf -X PATCH "${auth[@]}" "${API}/orgs/${ORG}/properties/values" -d '{
  "repository_names": ["'"${REPO}"'"],
  "properties": [
    { "property_name": "mc_version", "value": "1.21.1" },
    { "property_name": "status",     "value": "active" },
    { "property_name": "type",       "value": "library" }
  ]
}' >/dev/null && echo "    values assigned"

echo "==> Current values:"
curl -sf "${auth[@]}" "${API}/repos/${ORG}/${REPO}/properties/values"
echo
echo "Done."
