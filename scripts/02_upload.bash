#!/usr/bin/env bash
uploaddir=$(cd $(dirname $0)/..; pwd)/
host=openfmri #lonestar.tacc.utexas.edu # but through a proxy because we're blocked
echo "uploading $uploaddir"
## upload files to openfmri
rsync -Lazvhi $uploaddir lncd@$host:/corral-repl/utexas/poldracklab/openfmri/inprocess/pitt/antistate

ssh lncd@$host '/corral-repl/utexas/poldracklab/software_lonestar/local/bin/fixperms /corral-repl/utexas/poldracklab/openfmri/inprocess/pitt/antistate'
