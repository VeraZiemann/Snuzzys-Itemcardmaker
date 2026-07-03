#!/bin/bash

# flag long path output
LONG=false

while getopts "l" opt; do
  case $opt in
    l) LONG=true ;;
    *) echo "Usage: $0 [-l]"; exit 1 ;;
  esac
done

# test if directories have already been created
mkdir -p cards
mkdir -p items
mkdir -p images

# loop over files in items/
	# extract filename
	# check if file is not yet generated 
	# or
	# check if json is newer than pdf
		# compily typst

find ./items -type f -name "*.json" | while read -r file; do

    # relative path for correct placement
    rel_path="${file#./items/}"

    # get correct output
    output="cards/${rel_path%.json}.png"

    # target directory
    mkdir -p "$(dirname "$output")"

    # render only if:
    # - pdf does not exist
    # - json file changed
    # - main.typ changed
    rebuild=false
    
    if [ ! -f "$output" ] || \
       [ "$file" -nt "$output" ] || \
       [ "main.typ" -nt "$output" ]; then

        rebuild=true
    fi

    if [ "$rebuild" = true ]; then

        if [ "$LONG" = true ]; then
            echo "Rendering $output"
        else
            echo "Rendering $(basename "$output")"
        fi

        typst compile \
            main.typ \
            "$output" \
            --input item="$file"
        rebuild=false

    else
        if [ "$LONG" = true ]; then
            echo "Up to date: $output"
        else
            echo "Up to date: $(basename "$output")"
        fi
    fi

done

echo "Done."
