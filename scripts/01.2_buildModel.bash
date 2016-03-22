#!/usr/bin/env bash

# build model for antistate
# model all correct trials
# all corrected error trials
# all errors

# go to script directory
cd $(dirname $0)


## settings
ofmriDir="../"
task=task001
model=model001

## create model for task
# like 
#  task001 cond001 correct reward cue
#  task001 cond002 correct reward cue
condno=0
modelsdir=$ofmriDir/models/$model
[ ! -r $modelsdir ] && mkdir -p $modelsdir

for responsetype in correct corrected incorrect;  do
 for blocktype in AS PS; do
   for event in prep cue; do
     let ++condno
     cond="cond$(printf "%03d" $condno)"
     echo "$task $cond $responsetype $blocktype $event" 
   done
  done
done > $modelsdir/condtion_key.txt 

# give function
#  1. a file 
#  2. a block type (VGSCUE ANTICUE)
#  3. an event (prep cue resp)
# get back
#  list of onset set times for the specified
extrtiming() {
   f=$1
   block=$2
   event=$3
   # durations are 3, 4.5, and response time
   case "$event" in
     'prep') offset=0    ;dur=3;;
      'cue') offset=3    ;dur="1.5";;
      # 3rd field is saccade latency, that is the onset of response
     'resp') offset='3+$3';dur=".1";; 

     # after cu is same as it this is actually ITI
     *) echo "bad input $FUNCNAME: $@" && return 1;;
   esac

   awk "(\$2==1&&\$7==\"$block\"){print \$5+$offset, $dur, 1}" $f 
}

# for each subj and each of the subjs runs
for s in ../sub*/; do
 for rn in {1..4}; do
   run="run$(printf "%03d" $rn)"
   f=$s/behav/${task}_$run/behavdata.txt 
   [ ! -r $f ] && echo "missing file $f" && continue

   modelrun="$s/model/$model/onsets/${task}_$run"
   [ ! -d $modelrun ] && mkdir -p $modelrun
   
   #trial score lat(ms) runtype onset(s) end(s) trialtype cuepos
   # trailtype = VGSCUE (PS) ANTICUE (AS)

   # write each condition
   condno=0
   for responsetype in correct corrected incorrect;  do
    for blocktype in VGSCUE ANTICUE; do
      for event in prep cue; do
        let ++condno
        cond="cond$(printf "%03d" $condno)"
        extrtiming "$f" $blocktype $event > $modelrun/$cond
       done
     done
    done
   
 done
done
