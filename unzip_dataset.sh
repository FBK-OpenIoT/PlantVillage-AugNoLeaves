#!/bin/bash

# -----------------------------------------------------------------------------
# MIT License
#
# Copyright (c) 2025 OpenIoT Research Unit (Fondazione Bruno Kessler)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# -----------------------------------------------------------------------------

ZIP_DIR="data"
EXTRACT_DIR="extracted_dataset"
TMP_COMBINED="_combined.zip"

mkdir -p "$EXTRACT_DIR"

for zipfile in "$ZIP_DIR"/*.zip; do
    [ -f "$zipfile" ] || continue

    name=$(basename "$zipfile" .zip)
    temp_extract_dir=$(mktemp -d)
    target="$EXTRACT_DIR/$name"
    mkdir -p "$target"

    z01_part="${zipfile%.zip}.z01"

    if [ -f "$z01_part" ]; then
        echo "Combining split archive: $name"
        zip -s 0 "$zipfile" --out "$ZIP_DIR/$name$TMP_COMBINED"
        unzip -q "$ZIP_DIR/$name$TMP_COMBINED" -d "$temp_extract_dir"
        rm "$ZIP_DIR/$name$TMP_COMBINED"
    else
        echo "Extracting standard archive: $name"
        unzip -q "$zipfile" -d "$temp_extract_dir"
    fi

    # Find the deepest non-empty directory
    deepest=$(find "$temp_extract_dir" -type f -print0 | head -zn1 | xargs -0 dirname)

    if [ -d "$deepest" ]; then
        echo "Copying contents from: $deepest"
        find "$deepest" -mindepth 1 -exec cp -r -t "$target" -- {} +
    else
        echo "Warning: No files found to extract for $name"
    fi

    rm -rf "$temp_extract_dir"
done
