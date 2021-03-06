#!/bin/bash
while getopts "d:f:t:n:" arg
do
	case $arg in 
		d) 
			param="-a dates=DAYS -a length=$OPTARG"
			flag="days";;
		f) 
			param="-a dates=RANGE -a from=$OPTARG"
			flag="range";;
		t) 
			to=" -a to=$OPTARG";;
		n)
			name=$OPTARG;;
		?) 
			echo "Wrong option, try again"
			exit 1 ;;
	esac
done
if [ -z $flag ]; then
	echo "No valid options recived, try again"
    echo "----------"
    echo "Usage:"
    echo '   ./run.sh [-d <days>] [-f <from date> -t <to date>] [-n <filename>]'
    echo "Options:"
    echo '   -d <days>: Download articles in `days` days'
    echo '   -f <from> -t <to>: Download articles published from `from` to `to`'
    echo '   -n <filename>: default name is Jandan, so the default output is Jandan.epub'
	exit 1
elif [ $flag = "days" ]; then
	scrapy crawl jandan-article $param #-L INFO 
elif [ $flag = "range" ] && ! [ -z $to ]; then
	scrapy crawl jandan-article $param$to #-L INFO
else
	echo "Wrong options"
fi

if ! [ -z $name ]; then
	python mkepub.py -n $name
else
	python mkepub.py
fi
			

