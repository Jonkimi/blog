#!/bin/bash
roomid=1598612
cookie=`cat cookie.txt`
#echo $cookie
timestamp=`date +%s`
agent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"
refer="http://static.hdslb.com/live-static/swf/LivePlayerEx_1.swf"
signdata="color=16777215&fontsize=25&mode=1&msg=%23%E7%AD%BE%E5%88%B0&rnd=$timestamp&roomid=$roomid"
data="color=16777215&fontsize=25&mode=1&msg=%23%E6%9F%A5%E8%AF%A2&rnd=$timestamp&roomid=$roomid"

sign()
{
    curl -e "$refer" -A "$agent" -d "$signdata" -b "$cookie" -H "Host:live.bilibili.com" http://live.bilibili.com/msg/send
}

query()
{
    curl -e "$refer" -A "$agent" -d "$data" -b "$cookie" -H "Host:live.bilibili.com" http://live.bilibili.com/msg/send
}

run()
{
    sign
    sleep 2
    query
}

waitsecond()
{
    lasttime=$timestamp
    while [ true ]
    do 
        if [ `date +%s` -ge $(($lasttime+$1)) ]
	then
	    break
	fi
    done
}

main()
{

    lasttime=$timestamp
    count=1
    run
    printf "\n"
    while [ true ]
    do
	printf "`date`   : $count\n"
        sleep 1800
        count=$(($count+1))
        lasttime=`expr $lasttime+1800`
        run 
        printf "\n"
    done
#    while [ true ]
#    do 
#        if [ `date +%s` -ge $(($lasttime+1800)) ]
#	then
#	    count=$count+1
#	    printf "`date`   : $count\n"
#	    lasttime=`expr $lasttime+1800`
#	    run 
#	    printf "\n"
#	fi
 #   done
}
main

