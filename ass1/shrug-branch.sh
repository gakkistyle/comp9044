#!/bin/sh

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-branch: error: no .shrug directory containing shrug repository exists" >/dev/stderr;
    exit 1;
fi

#check any commit
now_branch=`cat .shrug/now_branch`;
if ! test -e  .shrug/branch/$now_branch/log
then
    echo "shrug-branch: error: your repository does not have any commits yet" >/dev/stderr;
    exit 1;
fi

#three condition,1 list all branches.2  delete a branch.3 create a new branch
if test "$#" -eq 0
then
	for dir in .shrug/branch/*
	do
		branch_name=`echo $dir|cut -d'/' -f3`;
		echo $branch_name;
	done
else

	if test "$1" = "-d"
	then
		#check for the valid branch name
		branch_match1=`echo $2|egrep '^[a-zA-Z0-9][a-zA-Z0-9\.\-\_]*$'`;
		branch_match2=`echo $2|egrep '^[0-9]+$'`;
		if test "$branch_match1" != "" && test "$branch_match2" = ""
		then
			#can not delete master
			if test "$2" = "master"
			then
				echo "shrug-branch: error: can not delete branch 'master'" >/dev/stderr;
				exit 1;
			fi
			#check if it exists
			if ! test -d ".shrug/branch/$2"
			then
				echo "shrug-branch: error: branch '$2' does not exist" >/dev/stderr;
				exit 1;
			fi

			#check if it is now branch
			if test "$2" = "$now_branch"
			then
				echo "shrug-branch: error: internal error error: Cannot delete branch '$2' checked out" >/dev/stderr;
				exit 1;
			fi

			#check if it is merged
			change=0
			latest_repo=`ls .shrug/branch/$2/repo|sort -r|head -n1`;
			
			for dir in .shrug/branch/*
			do
				if test "$dir" != ".shrug/branch/$2"
				then
					for reps in $dir/repo/*
					do
						num_repo=`echo $reps|cut -d'/' -f5`
						if test $num_repo -eq $latest_repo
						then
							change=1;
						fi
					done
				fi
			done
			#delete if changable
			if test $change -eq 1
			then
				rm -rf .shrug/branch/$2;
				echo "Deleted branch '$2'";
			else
				echo "shrug-branch: error: branch '$2' has unmerged changes" >/dev/stderr;
				exit 1;
			fi

		else
			echo "shrug-branch: error: invalid branch name '$2'" >/dev/stderr;
			exit 1;
		fi

	else
		#check for the valid branch name
		branch_match1=`echo $1|egrep '^[a-zA-Z0-9][a-zA-Z0-9\.\-\_]*$'`;
		branch_match2=`echo $1|egrep '^[0-9]+$'`;
		if test "$branch_match1" != "" && test "$branch_match2" = ""
		then
			#check if the branch already exists;
			if test -d ".shrug/branch/$1"
			then
				echo "shrug-branch: error: branch '$1' already exists" >/dev/stderr;
				exit 1;
			fi
			#create a new branch and add its name to branch_names
			mkdir .shrug/branch/$1;
			mkdir .shrug/branch/$1/repo;
			cp .shrug/branch/$now_branch/log .shrug/branch/$1/ ;
			cp -r .shrug/branch/$now_branch/index .shrug/branch/$1/index;
			latest_branch=`ls .shrug/branch/$now_branch/repo|sort -r|head -n1`;
			cp -r .shrug/branch/$now_branch/repo/$latest_branch .shrug/branch/$1/repo/$latest_branch ;

		else
			usage_match=`echo $1|egrep '^[-].*$'`;
			if test "$usage_match" != ""
			then
				echo "usage: shrug-branch [-d] <branch>" >/dev/stderr;
				exit 1;
			else
				echo "shrug-branch: error: invalid branch name '$1'" >/dev/stderr;
				exit 1;
			fi
		fi
	fi
fi
