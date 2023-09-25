#!/bin/bash

# whois scan
whois_scan() {
    tput setaf 6
    echo "Scanning the target using whois...\n"

    if [ -z "$2" ]; then
        # read the file containg urls and scan each url
        while IFS= read -r url; do
            whois $url
        done <$1
        echo "Scan completed.\n"
    else
        while IFS= read -r url; do
            whois $url >> $2
        done <$1
        echo "Scan completed. Results are saved to: $2\n"
    fi
    tput sgr0
}

# Parsing command line arguments
while getopts ":t:l:o:" opt; do
    case $opt in
    t) target="$OPTARG" ;;
    l) list="$OPTARG" ;;
    o) output="$OPTARG" ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

# Argument validation and preparation
if [ -z "$target" ] && [ -z "$list" ]; then
    tput setaf 1
    echo "Either the target or the target list must be given."
    tput sgr0
    exit 1
fi
if [ ! -z "$target" ] && [ ! -z "$list" ]; then
    tput setaf 3
    echo "Both the target and the target list are given. The target list will be used."
    target=""
    tput sgr0
fi

if [ ! -z "$target" ]; then
    echo $target >tmp.txt
    list="tmp.txt"
fi

if [ ! -z "$output" ]; then
    mkdir -p $output
fi


# Calling the functions based on the arguments
if [ -z "$output" ]; then
    whois_scan $list
else
    whois_scan $list $output/whois.txt
fi