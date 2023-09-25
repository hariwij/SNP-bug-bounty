#!/bin/bash
gobuster_scan() {
    tput setaf 6
    echo "Scanning the target using gobuster...\n"

    if [ -z "$4" ]; then
        while IFS= read -r url; do
            gobuster $2 -u $url -w $3
        done <$1
        echo "Scan completed.\n"

    else
        while IFS= read -r url; do
            gobuster $2 -u $url -w $3 >> $4
        done <$1
        echo "Scan completed. Results are saved to: $4\n"
    fi

    tput sgr0
}

# Parsing command line arguments
while getopts ":t:l:o:m:w:" opt; do
    case $opt in
    t) target="$OPTARG" ;;
    l) list="$OPTARG" ;;
    o) output="$OPTARG" ;;
    m) mode="$OPTARG" ;;
    w) wordlist="$OPTARG" ;;
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
    echo $target > tmp.txt
    list="tmp.txt"
fi

if [ ! -z "$output" ]; then
    mkdir -p $output
fi

if [ -z $mode ]; then
    mode="dir"
fi

if [ -z "$output" ]; then
    gobuster_scan $list $mode $wordlist
else
    gobuster_scan $list $mode $wordlist $output/gobuster-$mode.txt
fi
