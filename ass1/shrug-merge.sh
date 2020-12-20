#!/usr/bin/env dash

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-merge: error: no .shrug directory containing shrug repository exists">/dev/stderr;
    exit 1;
fi

#check any commit
now_branch=`cat .shrug/now_branch`;
if ! test -e  .shrug/branch/$now_branch/log
then
    echo "shrug-merge: error: your repository does not have any commits yet" >/dev/stderr;
    exit 1;
fi

#check commit message
if test $# -eq 1
then
	echo "shrug-merge: error: shrug-merge: error: empty commit message">/dev/stderr;
	exit 1;
fi

#check if $1 exists
if ! test -d .shrug/branch/$1
then
	echo "shrug-merge: error: unknown branch '$1'" >/dev/stderr;
    exit 1;
fi


#find largest common ancestor
latest_now_repo=`ls .shrug/branch/$now_branch/repo|sort -r|head -n1`;
latest_mer_repo=`ls .shrug/branch/$1/repo|sort -r|head -n1`;
com_ances=0;
now_log=`cat .shrug/branch/$now_branch/log|sed 's/ .*$//'`;

for line in $now_log
do
	match_=`egrep "^$line" .shrug/branch/$1/log`;
	if ! test "$match_" = ""
	then
		com_ances=$line;
	fi
done


if test $latest_mer_repo -eq $com_ances || (test $com_ances -eq $latest_now_repo && test $com_ances -gt $latest_mer_repo)
then
	echo Already up to date;
	exit 1;

fi

#check if local changes to files
for file in *
do
	if test -e .shrug/branch/$now_branch/repo/$latest_now_repo/$file
	then
		diff_curr_nowrepo=`diff $file .shrug/branch/$now_branch/repo/$latest_now_repo/$file|wc -w`;
		if test $diff_curr_nowrepo -gt 0
		then
			echo "shrug-merge: error: can not merge: local changes to files"
			exit 1;
		fi
	fi
done

#fast forward
if test $latest_now_repo -le $com_ances 
then
	#remove all files both in current dir and in repo and in index
	for file in *
	do
		if test -e .shrug/branch/$now_branch/repo/$latest_now_repo/$file
		then
			rm $file;
		fi 
	done
	rm -rf .shrug/branch/$now_branch/index/*;

	check_empty=`ls .shrug/branch/$1/repo/$latest_mer_repo/|wc -l`;
	#copy files to the new repo
	mkdir ".shrug/branch/$now_branch/repo/$latest_mer_repo";
	if test $check_empty -ne 0
	then
		cp -r .shrug/branch/$1/repo/$latest_mer_repo/ .;
		cp -r .shrug/branch/$1/repo/$latest_mer_repo/ .shrug/branch/$now_branch/index/;
		cp -r .shrug/branch/$1/repo/$latest_mer_repo/ .shrug/branch/$now_branch/repo/$latest_mer_repo/;
	fi
	log_content=`egrep "^$latest_mer_repo" ".shrug/branch/$1/log"`;
	echo $log_content >> .shrug/branch/$now_branch/log;
	echo Fast-forward: no commit created;
	exit 0;
fi

#check if there are files can not be merged
mergeable=1;
cannot_file="";
warn_file="";
dir_now_repo=".shrug/branch/$now_branch/repo/$latest_now_repo";
dir_mer_repo=".shrug/branch/$1/repo/$latest_mer_repo";
dir_anc_repo=".shrug/repo/$com_ances";

all_files=`ls  $dir_anc_repo/* $dir_now_repo/* $dir_mer_repo/* 2>/dev/null|sed 's/^\..*\///g'|sort|uniq`;
for file in $all_files
do
	if test -e $dir_anc_repo/$file 
	then
		if test -e $dir_now_repo/$file && ! test -e $dir_mer_repo/$file
		then
			dif_now_repo=`diff $dir_anc_repo/$file $dir_now_repo/$file|wc -w`;
			if test $dif_now_repo -gt 0
			then
				mergeable=0;
				cannot_file="$cannot_file $file";
			fi

		elif ! test -e $dir_now_repo/$file && test -e $dir_mer_repo/$file
		then
			dif_now_mer=`diff $dir_anc_repo/$file $dir_mer_repo/$file|wc -w`;
			if test $dif_now_mer -gt 0
			then
				mergeable=0;
				cannot_file="$cannot_file $file";

				#if file does exist ,create a copy of the merged repo
				if test -e $file*
				then
					if test -e $file
					then
						rm $file
					fi	
					if test -e "$file~$1"
					then
						num=0;
						while test -e "$file~$1$num"
						do
							num=$(($num + 1));
						done
						cp $dir_mer_repo/$file  "$file~$1$num";
					else
						cp $dir_mer_repo/$file  "$file~$1";
					fi
				fi
			fi	

		elif test -e $dir_now_repo/$file && test -e $dir_mer_repo/$file
		then
			row_now_repo=`wc -l $dir_now_repo/$file|sed 's/^ *//'|cut -d' ' -f1`;
			row_anc_repo=`wc -l $dir_anc_repo/$file|sed 's/^ *//'|cut -d' ' -f1`;
			row_mer_repo=`wc -l $dir_mer_repo/$file|sed 's/^ *//'|cut -d' ' -f1`;
			if test $row_now_repo -ne $row_anc_repo && test $row_now_repo -ne $row_mer_repo && test $row_mer_repo -ne $row_anc_repo
			then
				mergeable=0;
				cannot_file="$cannot_file $file";

			fi
		fi

	elif test -e $dir_now_repo/$file && test -e $dir_mer_repo/$file
	then
		dif_cur_mer=`diff $dir_now_repo/$file $dir_mer_repo/$file|wc -w`;
		if test $dif_cur_mer -gt 0
		then
			mergeable=0;
			cannot_file="$cannot_file $file";
		fi
	fi
done


if test $mergeable -eq 0
then
	echo "shrug-merge: error: These files can not be merged:" >/dev/null;
	echo "$cannot_file"|sed 's/ //'|tr ' ' '\n' >/dev/stderr;
	exit 1;
fi


echo "I can not solve the problem! It is too hard!";














