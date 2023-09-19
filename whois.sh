#!/bin/bash

# whois scan
whois_scan() {
    tput setaf 3
    echo "Scanning the target using whois...\n"

    if [ -z "$2" ]; then
        # read the file containg urls and scan each url
        while IFS= read -r url; do
            whois $url
        done <$1
        echo "Scan completed.\n"
    else
        while IFS= read -r url; do
            whois $url>>$2
        done <$1
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
    echo "Usage: ./whois.sh -t <target> [-o <output>]"
    exit 1
fi

if [ -z "$output" ]; then
    whois_scan $target
else
    whois_scan $target $output
fi
