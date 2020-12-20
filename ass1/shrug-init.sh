#!/usr/bin/env dash

if test -d ".shrug"
then
	echo "shrug-init: error: .shrug already exists";
	exit 1;
fi


mkdir ".shrug";
echo "master" > .shrug/now_branch;

mkdir .shrug/repo;
mkdir .shrug/branch;
mkdir .shrug/branch/master;
mkdir .shrug/branch/master/index;
mkdir .shrug/branch/master/repo;

echo "Initialized empty shrug repository in .shrug";
