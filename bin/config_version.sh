#!/bin/sh

# Usage
if [ $# -ne 1 ] || [ ! -d "$1" ]; then
	echo "usage: $0 <codepath>" >&2
	exit 1
fi

if type git >/dev/null; then
	# The git command is available.
	git --git-dir "$1/.git" describe --tags --dirty=-dev --always

else
	# Nothing else available; just use the date.
	date +%s

fi
