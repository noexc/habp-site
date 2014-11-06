#!/usr/bin/env bash

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"

if [ ! -f "$cwd/dist/build/habpsite/habpsite" ]; then
  echo "habpsite binary not found."
  exit 1
fi

rm -rf "$cwd/_site/" "$cwd/_cache/"

"$cwd/dist/build/habpsite/habpsite" build && rsync -Havzre 'ssh' --delete _site/ origin.noexc.org:/srv/www/nbp.noexc.org/
