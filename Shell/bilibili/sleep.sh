#!/data/data/com.termux/files/usr/bin/sh
main()
{
    printf "$0, $1, $2  \n"
    while true
    do
    sleep $1s
    printf `date +%s\n`
    done
}
main $1
