
This is a Linux shell script for checking lost/duplicated entries of EndNote folders.
Dev by Henrique Yoshikazu Shishido
E-mail: rickshido [at] yahoo [dot] com [dot] br

=======

checker.sh [-h | --help] -- program to check the difference between databases

where:
	-h | --help show this help text
====== 

How script works?

	To use this script it is necessary add .txt files into "all" and "sections" directory which are described as follows:

	"all" directory - contains files that compose all titles of comparison
	"sections" directory - contains files that will be compared with "all" titles

	Warning: It is important that the files are saved in .txt extension and in "EndNote" export style. Any other extension and export style will not work.
