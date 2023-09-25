#!/bin/bash

# nikto_scan() function
nikto_scan() {
    tput setaf 6
    echo "Scanning the target using nikto...\n"

    if [ -z "$2" ]; then
        while IFS= read -r url; do
            nikto --host $url
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            nikto --host $url >> $2
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
    nikto_scan $list
else
    nikto_scan $list $output/nikto.txt
fi


