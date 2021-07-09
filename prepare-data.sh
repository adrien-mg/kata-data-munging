#!/usr/bin/env bash
set -euo pipefail
#set -x

usage() {
    echo "usage: ./clean.sh <filename>"
}

if [ "$#" != 1 ]; then
   echo "error: please provide a single argument as file name"
   usage
   exit 1
fi

filename="$1"

cat "$filename"                 | \
    # deleting all dashes
    tr -d '-'                   | \
    # squeezing repeating sequences of whitespaces into a single whitespace
    tr -s ' '                   | \
    # squeezing repeating sequences of newlines into a single newline
    tr -s '\n'                  | \
    # only keeping lines containing one or more number, character, or dot
    egrep '^.*[0-9a-zA-Z.]+.*$' | \
    # removing leading whitespaces and dotted index
    sed -E 's/^ +(.*)/\1/g;s/^[0-9]+. (.*)/\1/g'
