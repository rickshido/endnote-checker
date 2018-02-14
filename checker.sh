#!/bin/bash

usage="\n$(basename "$0") [-h | --help] -- program to check the difference between databases

where:
	-h | --help show this help text\n

How script works?

	To use this script it is necessary add .txt files into \"all\" and \"sections\" directory which are described as follows:

	\"all\" directory - contains files that compose all titles of comparison
	\"sections\" directory - contains files that will be compared with \"all\" titles

	Warning: It is important that the files are saved in .txt extension and in \"EndNote\" export style. Any other extension and export style will not work.\n"

	echo -e "Developed by Henrique Yoshikazu Shishido\n"
	echo -e "E-mail: rickshido [at] yahoo [dot] com [dot] br"

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
	echo -e "$usage"
	exit 0
fi

clear
rm -rf duplicated/
rm -rf results.txt
rm -rf ./all/*.parsed
rm -rf ./all/*.sorted
rm -rf ./sections/*.sorted
rm -rf ./sections/*.parsed

mkdir duplicated

echo -e "\n==================================="
echo -e "EndNote Duplicator Entry Checker"
echo -e "====================================\n"

echo "**Parsing General folder..."
echo "- Parsing EndNote files to get only titles..."

for file in ./all/*.txt
do
	cat $file | grep ^%T  >> ./all/all.parsed
done

echo "- Sorting by letter..."
cat ./all/all.parsed | sort > ./all/all.sorted

echo "General folder has $(cat ./all/all.sorted | wc -l | sed -e 's/^[ \t]*//') titles..." 

echo -e "\n** Parsing section files..."
echo "- Parsing EndNote files to get only titles..."

for file in ./sections/*.txt
do
	cat $file | grep ^%T >> ./sections/sections.parsed
done

echo "- Sorting by letter..."
cat ./sections/sections.parsed | sort > ./sections/sections.sorted

echo "Sections folder has $(cat ./sections/sections.sorted | wc -l | sed -e 's/^[ \t]*//') titles..."

echo -e "\n** Applying diff command to "all.sorted" and "sections.sorted" files..."
diff ./all/all.sorted ./sections/sections.sorted | sed -e "s/> //g" | grep %T > ./duplicated/duplicated.txt

while read title
do

	grep -r --include=*.txt './sections/' -e "$title" | sed -e "s/.\/sections\/\///g" | sed -e "s/.txt//g" | sed -e "s/%T/ /g" >> results.txt
	echo "" >> results.txt

done < ./duplicated/duplicated.txt


echo -e "\nProcessing completed with sucessful!"

echo -e "\nThe results were saved in results.txt file\n"
