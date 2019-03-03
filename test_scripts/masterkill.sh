#!/bin/bash


pkill rcssserver
pkill rcssmonitor

trap ctrl_c INT

function ctrl_c()
{
  echo "Trap: CTRL+C received, exit"
  pkill --signal 15 rcssserver
  pkill --signal 15 rcssmonitor
  exit
}
