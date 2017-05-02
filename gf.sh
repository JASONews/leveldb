#!/bin/bash

BIN_DIR=out-static/
BIN=db_bench
NUM=50000000
NAME=$1
BENCHMARKS="$NAME"
OUTFILE="$NAME"
OUTDIR=$3/$OUTFILE
DBNAME=$2
OUTPUT="$OUTDIR/$OUTFILE"
FRESH=$4


STARTPOS=2
ENDPOS=30
STEP=2
RUNS=5

if [[ -z $1 ]]
then
	echo "no input benchmark"
	exit 1
fi

mkdir -p  $OUTDIR

echo "$BENCHMARKS start `date`"

for i in `seq $STARTPOS $STEP $ENDPOS`; do

	for j in `seq 1 $RUNS`; do
		
		sudo echo 3 > /proc/sys/vm/drop_caches
		sync

		$BIN_DIR$BIN --benchmarks=$BENCHMARKS --use_existing_db=$FRESH --db=$DBNAME --num=$NUM --growth_factor=$i --brief=1 >> $OUTPUT$j 

		printf "\n" >> $OUTPUT$j
		printf "\r$i:$j"

	done
	printf "...$(($i * 100 / $ENDPOS))%% `date`\n"

done

echo "merge to file $OUTDIR/result_$OUTFILE ..."

echo "growth factor,wall clcok time/s,var,micros/op,var,IOCost/us,var,Write Amplification,var" > $OUTDIR/result_$OUTFILE
cat $OUTPUT* >> $OUTDIR/result_$OUTFILE

echo "calculate average value ..."

nohup python avggf.py $OUTDIR/result_$OUTFILE

echo "done $BENCHMARKS"

exit 0
