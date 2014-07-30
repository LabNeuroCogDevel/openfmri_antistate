#!/usr/bin/env bash

## DEMOGRAPHICS
# sub001	051201162924	15.1184	M	10186	20051201	2005-12-01 00:00:00	1990-10-19 00:00:00
cut -f 1,3,4 txt/demographicFromSQL.txt > ../demographics.txt

## SCAN
echo "TR 1.5" > ../scan_key.txt

## TASK
cat > ../task_key.txt <<HEREDOC
antistate visual guided saccade (vgs) and antisaccace (anti) task
HEREDOC


## README
cat > ../README <<HEREDOC
# behavioral scoring 
-1: drop              trail eye tracking was not usuable (blink, presaccade, bad tracking, etc)
 0: incorrect         only incorrect saccades
 1: correct           first saccade is correct
 2: error corrected   first saccade is an error, but a later saccade (+fix) is to the correct position

Latency (in ms) is time from start of the trial until the first saccade. error corrected is latency of the first (error) saccade.

Scoring was done manually using matlab+ilab. There is a program to score, but it was not used for the paper.


# Citations

Velanova, K., M. E. Wheeler, and B. Luna. “Maturational Changes in Anterior Cingulate and Frontoparietal Recruitment Support the Development of Error Processing and Inhibitory Control.” Cerebral Cortex 18, no. 11 (November 1, 2008): 2505–22. doi:10.1093/cercor/bhn012.

Velanova, K., M. E. Wheeler, and B. Luna. “The Maturation of Task Set-Related Activation Supports Late Developmental Improvements in Inhibitory Control.” Journal of Neuroscience 29, no. 40 (October 7, 2009): 12558–67. doi:10.1523/JNEUROSCI.1579-09.2009.

Ordaz, S. J., W. Foran, K. Velanova, and B. Luna. “Longitudinal Growth Curves of Brain Function Underlying Inhibitory Control through Adolescence.” Journal of Neuroscience 33, no. 46 (November 13, 2013): 18109–24. doi:10.1523/JNEUROSCI.1741-13.2013.


HEREDOC
