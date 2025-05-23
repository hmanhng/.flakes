#!/usr/bin/env bash

bookmark=$(wl-paste -p)
file=$(dirname "$0")/bookmarks.txt

if (! echo $bookmark | grep -q "^http"); then
  notify-send "Opps." "Wrong bookmark!"
elif grep -q "^$bookmark$" "$file"; then
  notify-send "Opps." "Already bookmarked!"
else
  notify-send "Bookmark added!" "$bookmark is now saved to the file."
  echo "$bookmark" >>"$file"
fi
