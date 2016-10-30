#!/data/data/com.termux/files/usr/bin/bash

cookie=`cat cookie.txt`
timestamp=`date +%s`
agent="Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.87 Safari/537.36"
refer="http://static.hdslb.com/live-static/swf/LivePlayerEx_1.swf"
signdata="color=16777215&fontsize=25&mode=1&msg=%23%E7%AD%BE%E5%88%B0&rnd=$timestamp&roomid="
data="color=16777215&fontsize=25&mode=1&msg=%23%E6%9F%A5%E8%AF%A2&rnd=$timestamp&roomid="

#从roomid.txt中读取房间号，每行一个房间号
readrommid()
{
    cat roomid.txt | while read line
    do
        printf "roomid: $line\n"
        run $line
    done   
}

#签到请求
sign()
{
    curl -e "$refer" -A "$agent" -d "$signdata$1" -b "$cookie" -H "Host:live.bilibili.com" http://live.bilibili.com/msg/send
}

#查询积分请求
query()
{
    curl -e "$refer" -A "$agent" -d "$data$1" -b "$cookie" -H "Host:live.bilibili.com" http://live.bilibili.com/msg/send
}

#弹幕请求应该不许1s内多次发送，故每次请求等待数字上2s的差距，实际应该(1,2]s
run()
{
    sign $1
    waitsecond 2
    query $1
    waitsecond 2
    printf "\n"
}

#等待秒单位的时间，sleep在测试中差异太大
waitsecond()
{
    lasttime=`date +%s`
    while [ true ]
    do 
        if [ `date +%s` -ge $(($lasttime+$1)) ]
	then
	    break
	fi
    done
}

#周期半小时查询
main()
{
    count=1
    readrommid
    while [ true ]
    do
	printf "`date`   : $count\n"
        waitsecond 1800
        count=$(($count+1))
        readrommid
    done
}

main

