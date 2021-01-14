#!/usr/bin/env bash

# Customize those three lines with your repository and credentials:
REPO=https://api.github.com/repos/${GITHUB_REPOSITORY}
GITHUB_USER=${GITHUB_REPOSITORY%%/*}
GITHUB_TOKEN=${1}

# Number of most recent versions to keep for each artifact:
KEEP=4

# A shortcut to call GitHub API.
ghapi() { curl --silent --location --user "${GITHUB_USER}:${GITHUB_TOKEN}" "$@"; }

# A temporary file which receives HTTP response headers.
TMPFILE=/tmp/tmp.$$

# An associative array, key: artifact name, value: number of artifacts of that name.
declare -A ARTCOUNT

# Process all artifacts on this repository, loop on returned "pages".
URL=${REPO}/actions/artifacts
while [[ -n "${URL}" ]]; do

    # Get current page, get response headers in a temporary file.
    JSON=$(ghapi --dump-header ${TMPFILE} "${URL}")

    # Get URL of next page. Will be empty if we are at the last page.
    URL=$(grep '^Link:' "${TMPFILE}" | tr ',' '\n' | grep 'rel="next"' | head -1 | sed -e 's/.*<//' -e 's/>.*//')
    rm -f ${TMPFILE}

    # Number of artifacts on this page:
    COUNT=$(( $(jq <<<"${JSON}" -r '.artifacts | length') ))

    # Loop on all artifacts on this page.
    for ((i=0; i < COUNT; i++)); do

        # Get name of artifact and count instances of this name.
        STR=$(jq <<<"${JSON}" -r ".artifacts[${i}].name?")
        name=${STR%%-*}-${STR##*-}
        ARTCOUNT[$name]=$(( $(( ${ARTCOUNT[$name]} )) + 1))

        printf "Found '%s' #%d, " "${STR}" ${ARTCOUNT[${name}]}
        # Check if we must delete this one.
        if [[ ${ARTCOUNT[${name}]} -gt $KEEP ]]; then
            id=$(jq <<<"${JSON}" -r ".artifacts[${i}].id?")
            size=$(( $(jq <<<"${JSON}" -r ".artifacts[${i}].size_in_bytes?") ))
            printf "deleting %d bytes\n" ${size}
            ghapi -X DELETE "${REPO}/actions/artifacts/${id}"
        else
            printf "OK\n"
        fi
    done
done

exit 0
