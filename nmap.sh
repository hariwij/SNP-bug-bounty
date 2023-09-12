#!/bin/bash

# nmap scan
nmap_scan() {
    tput setaf 3
    echo "Scanning the target using nmap...\n"

    if [-z "$2"]; then
        nmap $1
        nmap -sS -iL $1

        echo "Scan completed.\n"

    else
        nmap -sS -iL $1 -oN $2
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

while getopts ":tl:o:" opt; do
    case $opt in
    tl) targetlist="$OPTARG" ;;
    o) output="$OPTARG" ;;
    \?)
        echo "Invalid option -$OPTARG" >&2
        ;;
    esac
done

if [ -z "$targetlist" ]; then
    echo "Usage: ./nmap.sh -tl <target_list> [-o <output>]"
    exit 1
fi

if [ -z "$output" ]; then
    nmap_scan $targetlist 
else
    nmap_scan $targetlist $output
fi
