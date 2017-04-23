#!/bin/bash

BIN_DIR=out-static/
BIN=db_bench
NUM=100000000
NAME=$1
BENCHMARKS="$NAME"
OUTFILE="$NAME"
OUTDIR=benchmark_results_5/$OUTFILE
OUTPUT="$OUTDIR/$OUTFILE"

STARTPOS=2
ENDPOS=40
STEP=2

if [[ -z $1 ]]
then
	echo "no input benchmark"
	exit 1
fi

mkdir -p  $OUTDIR


for i in `seq $STARTPOS $STEP $ENDPOS`; do

	for j in `seq 0 10`; do
		
		sudo echo 3 > /proc/sys/vm/drop_caches
		sync

		$BIN_DIR$BIN --benchmarks=$BENCHMARKS --num=$NUM --growth_factor=$i --brief=1 >> $OUTPUT$j 

		printf "\n" >> $OUTPUT$j
		printf "\r$i:$j"

	done
	printf "...$(($i * 2))%% `date`\n"

done

echo "merge to file $OUTDIR/result_$OUTFILE ..."

echo "growth factor,wall clcok time/s,IOCost/us,Write Amplification" > $OUTDIR/result_$OUTFILE
cat $OUTPUT* >> $OUTDIR/result_$OUTFILE

echo "calculate average value ..."

nohup python avggf.py $OUTDIR/result_$OUTFILE

echo "done $BENCHMARKS"

exit 0
