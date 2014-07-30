#!/usr/bin/env bash

# translate bircid into luna id
# get age
# get sex
# make subject number

# save output
demofile="txt/demographicFromSQL.txt"
[ ! -d $(dirname $demofile) ] && mkdir -p $(dirname $demofile)

count=0 # subject number

# for each of the subjects
for d in /data/Luna/Projects/INACTIVE/ARCHIVE/Anti_State/first_year/[0-9][0-9][0-9]*; do
   let count++
   BIRCID=$(basename $d)
   printf "sub%03d	$BIRCID	" $count
   mysql -u lncd -p'B@ngal0re' -h lncddb.acct.upmchs.net  lunadb_nightly -BNe "
               select datediff(VisitDate,DateOfBirth)/365.25 as age,
                 case sexID when 1 then 'M' when 2 then 'F' else '?' end as sex,
                 b.LunaId, date_format(VisitDate,'%Y%m%d') as visit, VisitDate,DateOfBirth
               from tbircids as b join tsubjectinfo as i on b.lunaid=i.lunaid 
               where b.BIRCID = $BIRCID;" |tr -d "\n"
  echo
done | tee $demofile


## get order info
beares="~/rcn/bea_res/"
# what subject did what order?
XLSperl -lane 'if($WS eq "Lookuptable"){print join("\t",@F{qw/H AJ AK AL AM/})}' $beares/Personal/Sarah/fMRI_Longitudinal/MACRO_RenameRawDataFiles.xls  > txt/subjOrders.txt
# what are the orders?
XLSperl -lane 'if($WS =~ /List(\d{2}[VA]{2})/ and $ROW>2 and $ROW<=28 and $ROW!=15 and $ROW!=16 ){ print join("\t",$1,@F{qw/K L M N/}) }' $beares/Personal/Sarah/fMRI_Longitudinal/Anti_Mix_Design_Lists.xls | sort -k1,1n -k2,2n > txt/listOrders.txt
