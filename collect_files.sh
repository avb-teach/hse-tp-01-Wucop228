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

python3 - <<EOF
import os
import shutil

max_depth=None if "$max_depth" == "" else int("$max_depth")
input_dir="$input_dir"
output_dir="$output_dir"

def get_all_files(directory):
    all_files = []
    for dirpath, _, filenames in os.walk(directory):
        current_depth = dirpath[len(input_dir):].count(os.path.sep)
        if max_depth is not None and current_depth > max_depth: continue

        for filename in filenames:
            all_files.append(os.path.join(dirpath, filename))
    return all_files

files = get_all_files(input_dir)

for filepath in files:
    if os.path.isfile(filepath):
        shutil.copy2(filepath, os.path.join(output_dir, os.path.basename(filepath)))
EOF