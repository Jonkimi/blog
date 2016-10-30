#!/bin/bash
cat roomid.txt | while read line
do
    echo $line
done
