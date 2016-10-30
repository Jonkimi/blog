#!/data/data/com.termux/bin/bash

waitsecond()
{
    lasttime=`date +%s`
    while [ true ]
    do
        if [ `date +%s` -ge $(($lasttime+$1)) ]
        then
            echo `date +%s`\n
            lasttime=`expr $lasttime+$1`
            break
        fi
    done
}
main()
{
    while true
    do
        waitsecond $1
    done       
}
main $1
