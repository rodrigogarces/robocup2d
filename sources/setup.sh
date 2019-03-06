#!/bin/bash

home=$PWD #Store current directory
cores=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}') #Get phisical cores

echo "This tutorial is based on https://github.com/herodrigues/robocup2d-tutorial/blob/master/sections/installing-the-soccer-simulator.md"
echo -e "Fedit2 installation is based on https://www.linuxquestions.org/questions/ubuntu-63/error-in-installing-fedit2-4175632099/\n\n"
echo "Install process can take 5~30 min, deppending on your pc and internet speed"
echo "Script developed by Rodrigo Garcês"
echo "UFMA 2018-2019"

echo "Installing dependencies"
sudo apt-get install -y g++ build-essential libboost-all-dev qt4-default qt4-dev-tools qt4-qmake libaudio-dev libgtk-3-dev libxt-dev doxygen tcsh

echo "Adding robocup 2d repository"
sudo apt-add-repository -y ppa:gnurubuntu/rubuntu
sudo apt-get update

echo "Installing rcssserver rcssmonitor rcsoccersim rcsslogplayer"
sudo apt-get install -y rcssserver rcssmonitor rcsslogplayer

cd $home
echo "Installing librcsc"
cd librcsc-4.1.0
sudo ./configure
make -j $cores
sudo make install

cd $home
echo "Installing fedit2"
cd ../fedit2
export QT_SELECT=4
qmake fedit2.pro
make -j $cores
alias fedit2="$PWD/bin/fedit2"

cd $home
cd ../base_teams
home=$PWD #Store base_teams as current directory
echo "Installing agent2d"
cd agent2d-3.1.1/
sudo ./configure
make -j $cores

cd $home
echo "Installing UvA Trilearn"
cd trilearn_base_sources-3.3-v13-by_PET
sudo ./configure
make -j $cores

echo "Installation complete"
echo "Open a new terminal instance or reload terminal (source ~/.bashrc) to apply changes"
echo "Run fix_decimal_separator.sh IF your system use comma (,) instead of dot (.) as decimal separator"
