#!/bin/bash

journal_folder="$HOME/Brain/journal"
journal_extension=".jnl"

today_file=`date +"%Y%m%d"`
today_header=`date +"%A, %d %B %Y"`

journal_file="${journal_folder}/${today_file}${journal_extension}"

echo $journal_file

# if journal file doesn't exist create it
if [ -f "$journal_file" ]; then 
	echo "${journal_file} exists."
else 
	echo -e "* ${today_header}\n" >> "$journal_file"
fi

emacs -nw $journal_file
