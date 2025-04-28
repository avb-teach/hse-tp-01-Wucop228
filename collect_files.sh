#!/bin/bash

max_depth=""
input_dir=""
output_dir=""

if [ "$1" = "--max_depth" ]; then
    max_depth="$2"
    input_dir="$3"
    output_dir="$4"
else
    input_dir="$1"
    output_dir="$2"
fi

mkdir -p "$output_dir"

