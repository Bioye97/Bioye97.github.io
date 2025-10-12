#!/usr/bin/env bash
#
# Script to update copyright year of all html files
#
# Usage: bash admin/copyright_year.sh

lastyear=2025
newyear=2026

# Check we are in the top-level directory
if [ ! -f CNAME ]; then
    echo "Must be run from top-level directory"
    exit 1
fi

# Set temporary directory
TMPDIR=${TMPDIR:-${TEMP:-${TMP:-/tmp}}}

# 1. Find all html files with "©"
find . -name '*.html' -exec grep -H © {} + | grep -v ${newyear} | awk -F: '{print $1}' > ${TMPDIR}/$$.tmp.lis 

# 2. Update the files
while read f; do
    sed -E -i.bak "s/©([0-9]+)-${lastyear}/© \1-${newyear}/" $f
    rm -f $f.bak
done < ${TMPDIR}/$$.tmp.lis 

# 3. Clean up
rm -f ${TMPDIR}/$$.tmp.lis



