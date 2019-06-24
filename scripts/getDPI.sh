#!/bin/bash

_product_family=$(cat /sys/class/dmi/id/product_family)
DEFINE_DPI=('ThinkPad X1 Carbon 2nd' 128)
_idx=0
for elem in "${DEFINE_DPI[@]}"; do
	((_idx++))
	if [ "$elem" = "$_product_family" ]; then
		echo ${DEFINE_DPI[$_idx]}
		exit
	fi
done
echo 96
exit
