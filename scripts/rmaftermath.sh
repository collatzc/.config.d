#!/bin/sh

target_dir=$1

if [ -d "$target_dir" ]; then
	for f in "$target_dir"*; do
		ff=$(basename $f)
		echo $ff
		rm -rf $ff
	done
else
	echo "Target $target_dir not exists."
fi
