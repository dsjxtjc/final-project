#!/bin/user
cat record | awk -F ' ' '{print $1}' | uniq -d > temp_summary
cat /dev/null > temp_direct

#制作表头
echo >> temp_direct
echo -ne "File\t" >> temp_direct
echo "Chunk" >> temp_direct
cat temp_summary | while read line
do
    name=$1" "
    total=$(grep "$line" record | wc -l)
    single=$(grep "$line" record | sort -t ' ' -k 2,2 -u | wc -l)
    rep_prim=$(($total/$single))
    echo -ne $line >> temp_direct
    echo -ne "\t" >> temp_direct
    echo $rep_prim >> temp_direct
done
echo >> temp_direct
cat temp_direct
rm temp_direct
rm temp_summary


