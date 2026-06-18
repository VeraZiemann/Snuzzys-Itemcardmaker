#!/bin/bash

# loop over files
	# extract filename
	# check if file is not yet generated 
	# or
	# check if json is newer than pdf
		# compily typst

for file in items/*.json; do

    name=$(basename "$file" .json)

    output="cards/${name}.png"

    # render only if:
    # - pdf does not exist
    # - json file changed
    # - main.typ changed
    
    if [ ! -f "$output" ] || \
       [ "$file" -nt "$output" ] || \
       [ "main.typ" -nt "$output" ]; then

        rebuild=true
    fi

    if [ "$rebuild" = true ]; then

        echo "Rendering $output"

        typst compile \
            main.typ \
            "$output" \
            --input item="$file"
        rebuild=false

    else
        echo "Up to date: $output"
    fi

done

echo "Done."
