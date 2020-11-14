#!/bin/bash

VERSION=dev

set -e
cd game
wasm-pack build --release --target web -- --no-default-features --features wasm,wasm_s3
cd pkg
# Temporarily remove the symlink to the data directory; it's uploaded separately by the updater tool
rm -f system
aws s3 sync . s3://abstreet/$VERSION
# Undo that symlink hiding
git checkout system
echo "Have the appropriate amount of fun: http://abstreet.s3-website.us-east-2.amazonaws.com/$VERSION"
