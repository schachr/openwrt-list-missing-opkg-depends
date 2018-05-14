#!/bin/sh

for _package in $(opkg list-installed | sed 's/ - .*//g') ; do 
	for _depends in $(opkg info ${_package} | egrep "^Depends: " | sed 's/^Depends: //g' | sed 's/ (.*)//g' | sed 's/,//g' | uniq) ; do
		opkg list-installed | sed 's/ - .*//g' | egrep "^${_depends}$" > /dev/null || echo "${_package} misses dependency: ${_depends}"
	done
done
