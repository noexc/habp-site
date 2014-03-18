#!/usr/bin/env bash

cwd="$( cd "${BASH_SOURCE[0]%/*}" && pwd )"

if [ ! -f "$cwd/dist/build/habpsite/habpsite" ]; then
  echo "habpsite binary not found."
  exit 1
fi

"$cwd/dist/build/habpsite/habpsite" clean
"$cwd/dist/build/habpsite/habpsite" watch
