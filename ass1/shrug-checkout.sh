#!/bin/sh

#check .shrug exists
if ! test -d .shrug/
then
    echo "shrug-checkout: error: no .shrug directory containing shrug repository exists" >/dev/stderr;
    exit 1;
fi

#check any commit
now_branch=`cat .shrug/now_branch`;
if ! test -e  .shrug/branch/$now_branch/log
then
    echo "shrug-checkout: error: your repository does not have any commits yet" >/dev/stderr;
    exit 1;
fi

#check if $1 is current branch
checout_branch=$1;
if test "$checout_branch" = "$now_branch"
then
	echo "Already on '$now_branch'" >/dev/stderr;
	exit 1;
fi

#check if $1 exists
if ! test -d .shrug/branch/$1
then
	echo "shrug-checkout: error: unknown branch '$1'" >/dev/stderr;
    exit 1;
fi

#check if it can be checked out
latest_now_repo=`ls .shrug/branch/$now_branch/repo|sort -r|head -n1`;
latest_swi_repo=`ls .shrug/branch/$1/repo|sort -r|head -n1`;

dir_now_repo=".shrug/branch/$now_branch/repo/$latest_now_repo";
dir_swi_repo=".shrug/branch/$1/repo/$latest_swi_repo";

checkable=1;
cannot_file=""
for file in *
do
	if test -e "$dir_now_repo/$file"
	then
		dif_now_repo=`diff $file $dir_now_repo/$file|wc -w`;
		if test $dif_now_repo -gt 0
		then
			if test -e "$dir_swi_repo/$file"
			then
				dif_swi_repo=`diff $dir_now_repo/$file $dir_swi_repo/$file|wc -w`;
				if test $dif_swi_repo -gt 0
				then
					checkable=0;
					cannot_file="$cannot_file $file";
				fi
			else
				checkable=0;
				cannot_file="$cannot_file $file";
			fi
		fi
	else
		if test -e "$dir_swi_repo/$file"
		then
			checkable=0;
			cannot_file="$cannot_file $file";
		fi
	fi
done

if test $checkable -eq 0
then
	echo "shrug-checkout: error: Your changes to the following files would be overwritten by checkout:" >/dev/stderr;
	echo "$cannot_file"|sed 's/ //'|tr ' ' '\n' >/dev/stderr;
	exit 1;
fi


#finally change the current directory
dir_now_index=".shrug/branch/$now_branch/index";
dir_swi_index=".shrug/branch/$1/index";
ls * $dir_now_index/* $dir_now_repo/* $dir_swi_repo/* 2>/dev/null|sed 's/^\..*\///g'|sort|uniq|
while read filename
do
	if test -e "$dir_swi_repo/$filename"
	then
		if ! test -e "$filename"
		then
			cp "$dir_swi_repo/$filename" .;
		else
			dif_now_repo=`diff $filename $dir_now_repo/$filename|wc -w`;
			if test $dif_now_repo -eq 0
			then
				rm "$filename";
				cp "$dir_swi_repo/$filename" .;
			else
				#a tricky point here is to copy the index in current index to the new branch index
				if test -e "$dir_now_index/$filename"
				then
					dif_now_index=`diff $filename $dir_now_index/$filename|wc -w`;
					if test $dif_now_index -eq 0
					then
						cp "$filename" ".shrug/branch/$1/index";
					fi
				fi
			fi
		fi
		#check the committed status, and update the switched branch index if necessary
		if test -e "$dir_swi_index/$filename" && test -e "$dir_now_index/$filename" && test -e "$dir_now_repo/$filename"
		then
			dif_nindex_repo=`diff $dir_now_index/$filename $dir_now_repo/$filename|wc -w`;
			dif_sindex_repo=`diff $dir_swi_index/$filename $dir_swi_repo/$filename|wc -w`;
			if test $dif_nindex_repo -eq 0 && test $dif_sindex_repo -gt 0
			then
				cp $dir_swi_repo/$filename $dir_swi_index ;
			fi
		fi
	else
		#if the file only exists in now branch index,then copy it to the switched branch index.
		if ! test -e "$dir_swi_repo/$filename" && ! test -e "$dir_now_repo/$filename"
		then
			if test -e "$dir_now_index/$filename"
			then
				cp "$dir_now_index/$filename" "$dir_swi_index";
			fi
		else
			if test -e "$filename"
			then
				if test -e "$dir_now_repo/$filename"
				then
					rm "$filename";
				fi
			fi
		fi
	fi
done

echo "Switched to branch '$1'";
echo "$1" > .shrug/now_branch;
