#!/bin/sh

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-rm: error: no .shrug directory containing shrug repository exists";
    exit 1;
fi


flag_f=0;
flag_c=0;

if test "$1" = "--force" 
then
	flag_f=1;
	shift;
	if test "$1" = "--cached"
	then
		flag_c=1;
		shift;
	fi
fi

if test "$1" = "--cached"
then
	flag_c=1;
	shift;
fi

now_branch=`cat .shrug/now_branch`;
#first check all files are in index
for filename in "$@"
do
	if ! test -e .shrug/branch/$now_branch/index/$filename
	then
		echo "shrug-rm: error: '$filename' is not in the shrug repository";
		exit 1;
	fi
done

#force is 1
if test $flag_f -eq 1
then
	for file in "$@"
	do
		rm ".shrug/branch/$now_branch/index/$file";
	done
	#if no cached flag , also remove the curr dir files.
	if test $flag_c -eq 0
	then
		for file in "$@"
		do
			if test -e  $file
			then 
				rm "$file" ;
			fi
		done
	fi
	exit 0;
fi

change=1;
#then check for if the contents different between index and current dir or index and repo
num=`ls -c .shrug/repo|wc -l|sed 's/ //g'`;
latest_branch=`ls .shrug/branch/$now_branch/repo|sort -r|head -n1`;
for file in "$@"
do
	if test -e $file
	then
		if_dif_curr=`diff $file .shrug/branch/$now_branch/index/$file|wc -w`;
		if test $if_dif_curr -gt 0
		then
			if test $num -eq 0
			then
				if test $if_dif_curr -gt 0
				then
					change=0;
				fi
			else
				if ! test -e  .shrug/branch/$now_branch/repo/$latest_branch/$file
				then
					change=0;
				else
					if_dif_repo=`diff .shrug/branch/$now_branch/index/$file .shrug/branch/$now_branch/repo/$latest_branch/$file|wc -w`;
					if test $if_dif_repo -gt 0
					then
						change=0;
					fi
				fi
			fi
		fi
	fi
	if test $change -eq 0
	then
		echo "shrug-rm: error: '$file' in index is different to both working file and repository";
		exit 1;
	fi
done


#only cached flag,then only rm the index file
if test $flag_c -eq 1 && test $change -eq 1
then
	for file in "$@"
	do
		rm ".shrug/branch/$now_branch/index/$file";
	done
fi


#no flag at all, then need to check if the index files already be committed
#and need to mention that if the file already be removed from the current dir,then just directly remove the index one.
if test $flag_c -eq 0 && test $flag_f -eq 0
then
	for file in "$@"
	do
		if test -e $file
		then
			#check the repo
			if_dif_curr=`diff $file  .shrug/branch/$now_branch/index/$file|wc -w`;
			if test $if_dif_curr -eq 0
			then
			#if 0 repo,then quit
				if test $num -eq 0
				then
					echo "shrug-rm: error: '$file' has changes staged in the index";
					exit 1;
				else
					#if the latest repo does not have the file ,then quit
					if ! test -e .shrug/branch/$now_branch/repo/$latest_branch/$file
					then
						echo "shrug-rm: error: '$file' has changes staged in the index";
						exit 1;
					else
					#does not the same file
						if_dif_repo=`diff .shrug/branch/$now_branch/index/$file .shrug/branch/$now_branch/repo/$latest_branch/$file|wc -w`;
						if test $if_dif_repo -gt 0
						then
							echo "shrug-rm: error: '$file' has changes staged in the index";
							exit 1;
						fi
					fi
				fi
			else
				if test $num -gt 0
				then
					if test -e .shrug/branch/$now_branch/repo/$latest_branch/$file
					then
						if_dif_repo=`diff .shrug/branch/$now_branch/index/$file .shrug/branch/$now_branch/repo/$latest_branch/$file|wc -w`;
						if test $if_dif_repo -eq 0
						then
							echo "shrug-rm: error: '$file' in repository is different to working file";
							exit 1;
						fi
					fi
				fi
			fi
		fi
	done
	for file in "$@"
	do
		rm ".shrug/branch/$now_branch/index/$file";
		if test -e $file
		then
			rm "$file";
		fi
	done
fi

















