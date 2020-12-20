#!/bin/sh

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-status: error: no .shrug directory containing shrug repository exists";
    exit 1;
fi

#check .shrug/log exists
now_branch=`cat .shrug/now_branch`;
if ! test -e  .shrug/branch/$now_branch/log
then
    echo "shrug-status: error: your repository does not have any commits yet";
    exit 1;
fi



num=`ls -c .shrug/repo|wc -l|sed 's/ //g'`;
latest_branch=`ls .shrug/branch/$now_branch/repo|sort -r|head -n1`;
dir_index=".shrug/branch/$now_branch/index";
dir_now_repo=".shrug/branch/$now_branch/repo/$latest_branch";

ls * $dir_index/* $dir_now_repo/* 2>/dev/null|sed 's/^\..*\///g'|sort|uniq|
while read filename
do
	file_index="$dir_index/$filename";
	file_repo="$dir_now_repo/$filename";

	#the file is not in index , then it is untracked.
	if ! test -e "$file_index"
	then
		if test -e "$filename"
		then
			echo "$filename - untracked";
		else
			echo "$filename - deleted";
		fi
	else
		if ! test -e "$file_repo"
		then
			if test -e "$filename"
			then
				dif_index_curr=`diff "$filename" "$file_index"|wc -w`;
				if test $dif_index_curr -eq 0
				then
					echo "$filename - added to index";
				else
					echo "$filename - added to index, file changed";
				fi
			else
				echo "$filename - added to index, file deleted";
			fi
		else
			if ! test -e "$filename"
			then
				dif_index_repo=`diff "$file_repo" "$file_index"|wc -w`;
				if test $dif_index_repo -gt 0
				then
					echo "$filename - file deleted, defferent changes staged for commit";
				else
					echo "$filename - file deleted";
				fi
			else
				dif_index_repo=`diff $file_repo $file_index|wc -w`;
				dif_index_curr=`diff $file_index $filename|wc -w`;
				if test $dif_index_curr -eq 0 && test $dif_index_repo -eq 0
				then
					echo "$filename - same as repo";
				elif test $dif_index_curr -eq 0 && test $dif_index_repo -gt 0
				then
					echo "$filename - file changed, changes staged for commit";
				elif test $dif_index_curr -gt 0 && test $dif_index_repo -eq 0
				then
					echo "$filename - file changed, changes not staged for commit";
				else
					echo "$filename - file changed, different changes staged for commit";
				fi
			fi
		fi
	fi
done