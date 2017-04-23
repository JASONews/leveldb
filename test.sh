#!/bin/bash

BHCHS="fillseq fillrandom overwrite fillsync readseq readrandom readmissing readhot seekrandom deleteseq deleterandom"

for i in $BHCHS
do
	echo $i
	nohup ./gf.sh $i
done

exit 0
