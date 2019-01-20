#!/bin/bash

trap "kill 0" EXIT

def=6000
batch=2 #total batches to be executed
match=2 #mathes on each batch
interval=8

batch=$((batch - 1))
match=$((match - 1))


#execute batch
for (( a=0; a<=$batch; a++ ))
do


  #execute match
  for (( i=0; i<=$match; i++ ))
  do

      server=$(($def))
      coach=$(($def + 1))
      olcoach=$(($def + 2))

      echo $server
      echo $coach
      echo $olcoach


      mkdir $i #make temporary directory to store logs
      rcssserver server::auto_mode=on server::port=$server server::coach_port=$coach server::olcoach_port=$olcoach server::game_log_dir=./$i server::text_log_dir=./$i&  # automatically start the game

      #cd ~/ufma2d/src
      ~/ufma2d/src/start.sh -p $server -P $olcoach&

      #cd ~/agent2d-3.1.1/src
      ~/agent2d-3.1.1/src/start.sh -p $server -P $olcoach&

      rcssmonitor --server-port $server&


      def=$(($def + 3))
      sleep $interval
  done


  #wait #if you want to see final result

  #if you dont wanna to see final result (usefull when using batch)
  sleep 3
  while true
    do
    ps cax | grep rcssserver >/dev/null
    if [ $? -eq 0 ]; then
      echo "exec"
      sleep 10
    else
      echo -e "nope\ngoodbye"
      pkill --signal 15 rcssserver
      pkill --signal 15 rcssmonitor
      sleep 5
      break
    fi
  done

  echo "Well done"
  #move logs
  for (( i=0; i<=$match; i++ ))
  do
    cd $i
    mv * ~
    cd ~
    rm -r $i #remove temporary directory
  done

done #end batch
