#!/bin/bash

FILLBHCHS="fillseq"
READBHCHS="readseq readrandom readmissing readhot seekrandom overwrite deleteseq deleterandom"

if [[ -z $1 ]]
then
DBNAME="db_t"
else
DBNAME=$1
fi

OUTDIRNAME=results_benchmarks

TEMPNAME=$DBNAME
count=0
while [[ -d $TEMPNAME ]]; do
        count=$(($count+1))
        TEMPNAME=$DBNAME"_$count"
done
DBNAME=$TEMPNAME
mkdir -p $DBNAME

count=0
TEMPNAME=$OUTDIRNAME
while [[ -d $TEMPNAME ]]; do
        count=$(($count+1))
        TEMPNAME=$OUTDIRNAME"_$count"
done
OUTDIRNAME=$TEMPNAME


echo $FILLBHCHS
nohup ./gf.sh $FILLBHCHS $DBNAME $OUTDIRNAME 0

for i in $READBHCHS
do
	echo $i
	nohup ./gf.sh $i $DBNAME $OUTDIRNAME 1
done

exit 0
