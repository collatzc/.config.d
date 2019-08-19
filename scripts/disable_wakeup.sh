#!/bin/bash
# Thinkpad T480 can't suspend because USB 3.0 controller
# remove XHC from wakeup

if [ "$(cat /proc/acpi/wakeup | grep enabled | grep XHC)" != "" ]; then
	echo "XHC" > /proc/acpi/wakeup
fi
