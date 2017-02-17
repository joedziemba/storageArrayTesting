echo "Press '1' if you have set your array's path"
echo "or press '2' if you haven't set your path."
read -n1 -r -p "Please choose" key

if [ "$key" = "1" ]; then
	## Measuring write speeds
	## 1GB of data writen
	dd if=/dev/zero of=/path/to/array/test1.img bs=1G count=1 oflag=dsync 2> test1.txt
	echo "Write test is done and output is in test1.txt"

	## Measuring latency
	dd if=/dev/zero of=/path/to/array/test2.img bs=512 count=1000 oflag=dsync 2> test2.txt
	echo "Latency test is done and output is in test2.txt"

	## Measuring write without cache
	hdparm --W0 /dev/sd*
	dd if=/dev/zero of=/path/to/array/ bs=1G count=1 oflag=direct 2> test3.txt
	echo "Write without cache is done and output is in test3.txt"

	echo "Please open the disk utility and run the benchmark for the storage array."
else
	echo "Please edit this script, changing the path of your array/pool"
	echo "ex. /dev/sdc"
	echo "save then run again"
fi