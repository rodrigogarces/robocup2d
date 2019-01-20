#!/bin/bash
trap "kill 0" EXIT

def=6000
match=3
#interval=800

match=$((match - 1))

#for i in {0.. $match}
for (( i=0; i<=$match; i++ ))
do

    server=$(($def))
    coach=$(($def + 1))
    olcoach=$(($def + 2))

    echo $server
    echo $coach
    echo $olcoach


    cd ~
    rcssserver server::auto_mode=on server::port=$server server::coach_port=$coach server::olcoach_port=$olcoach&  # automatically start the game

    cd ~/agent2d-3.1.1/src
    ./start.sh &#-p $server -P $olcoach&

    #cd ~/agent2d-3.1.1/src
    cd ~/ufma2016
    #./start.sh -p $server -P $olcoach&
    ./start.sh localhost ufma2016&

    rcssmonitor --server-port $server&



    sleep 3

    while true
      do
      ps cax | grep rcssserver >/dev/null
      if [ $? -eq 0 ]; then
        echo "exec"
        sleep 10
      else
        sleep 5
        echo -e "nope\ngoodbye"
        pkill --signal 15 rcssserver
        pkill --signal 15 rcssmonitor
        break
      fi
    done

done
