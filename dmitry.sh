#!/bin/bash

# dmitry scan
dmitry_scan() {
    tput setaf 3
    echo "Scanning the target using dmitry...\n"

    if [ -z "$2" ]; then
        dmitry -winsepfb $1
        echo "Scan completed.\n"

    else
        dmitry -winsepfb $1 -o $2
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
    echo "Usage: ./dmitry.sh -t <target> [-o <output>]"
    exit 1
fi

if [ -z "$output" ]; then
    dmitry_scan $target
else
    dmitry_scan $target $output
fi