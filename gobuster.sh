#!/bin/bash

gobuster_scan() {
    tput setaf 3
    echo "Scanning the target using gobuster...\n"

    if [ -z "$4" ]; then
        gobuster $3 -u $1 -w $2
        echo "Scan completed.\n"

    else
        gobuster $3 -u $1 -w $2 -o $4
        echo "Scan completed. Results are saved to: $3\n"
    fi

    tput sgr0
}

while getopts ":t:m:w:o:" opt; do
    case $opt in
    t) target="$OPTARG" ;;
    m) mode="$OPTARG" ;;
    w) wordlist="$OPTARG" ;;
    o) output="$OPTARG" ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

if [ -z "$target" ] || [ -z "$wordlist" ]; then
    echo "Usage: ./gobuster.sh -t <target> -m <mode> -w <wordlist> [-o <output>]"
    exit 1
fi

if[ -z "$mode" ]; then
    mode="dir"
fi

if [ -z "$output" ]; then
    gobuster_scan $target $wordlist $mode
else
    gobuster_scan $target $wordlist $mode $output
fi
