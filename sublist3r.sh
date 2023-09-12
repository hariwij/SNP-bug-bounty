#!/bin/bash

# install sublist3r
install() {
    tput setaf 6
    echo "Installing sublist3r..."
    git clone https://github.com/aboul3la/Sublist3r.git
    cd Sublist3r/
    sudo pip3 install -r requirements.txt
    echo "Sublist3r is installed.\n\n"
    cd ..
    tput sgr0
}

# sublist3r scan
sublist3r_scan(){
    tput setaf 3
    echo "Scanning the target using sublist3r...\n"

    if [ -z "$2" ]; then
        python3 ./Sublist3r/sublist3r.py -v -d $1
        echo "Scan completed.\n"

    else
        python3 sublist3r.py -d $1 -o $2
        echo "Scan completed. Results are saved to: $2\n"
    fi

    tput sgr0
}

# check if sublist3r is installed
if [ -d "./Sublist3r" ]; then
    echo "Sublist3r is already installed."
    echo "Do you want to reinstall it? (y/n)"
    read answer
    echo "\n\n"
    if [ "$answer" == "y" ]; then
        sudo rm -r Sublist3r/
        install
    fi
else
    install
fi

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
    echo "Usage: ./sublist3r.sh -t <target> [-o <output>]"
    exit 1
fi

if [ -z "$output" ]; then
    sublist3r_scan $target
else
    sublist3r_scan $target $output
fi
