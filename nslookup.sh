#!/bin/bash

# nslookup scan
nslookup_scan() {
    tput setaf 3
    echo "Scanning the target using nslookup...\n"

    if [ -z "$2" ]; then
        nslookup $1
        echo "Scan completed.\n"

    else
        nslookup $1 2>$2
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

while getopts ":t:o:" opt; do
    case $opt in
    t) target="$OPTARG" ;;
    o) output="$OPTARG" ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

if [ -z "$target" ]; then
    echo "Usage: ./nslookup.sh -t <target> [-o <output>]"
    exit 1
fi

if [ -z "$output" ]; then
    nslookup_scan $target
else
    nslookup_scan $target $output
fi