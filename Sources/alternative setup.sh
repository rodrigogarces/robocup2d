#!/bin/bash

home=$PWD #Store current directory

echo "this tutorial is based on https://github.com/herodrigues/robocup2d-tutorial/blob/master/sections/installing-the-soccer-simulator.md"
echo "fedit2 installation is based on https://www.linuxquestions.org/questions/ubuntu-63/error-in-installing-fedit2-4175632099/"
echo "Install process can take 5~30 min, deppending on your pc and internet speed"

echo "Installing dependencies"
sudo apt-get install -y g++ build-essential libboost-all-dev qt4-default qt4-dev-tools qt4-qmake libaudio-dev libgtk-3-dev libxt-dev doxygen tcsh

echo "Adding robocup 2d repository"
sudo apt-add-repository -y ppa:gnurubuntu/rubuntu
sudo apt-get update

echo "Installing rcssserver rcssmonitor rcsoccersim rcsslogplayer"
sudo apt-get install -y rcssserver rcssmonitor rcsslogplayer

cd $home
echo "Installing librcsc"
#wget http://c3sl.dl.osdn.jp/rctools/51941/librcsc-4.1.0.tar.gz
tar -xf librcsc-4.1.0.tar.gz
cd librcsc-4.1.0
sudo ./configure
sudo make
sudo make install

cd $home
echo "Installing fedit2"
#git clone https://github.com/KN2C/rctools.git
unzip rctools-master.zip
cd rctools-master/fedit2-0.0.0/
export QT_SELECT=4
qmake fedit2.pro
make

cd $home
echo "Installing agent2d"
#wget http://c3sl.dl.osdn.jp/rctools/55186/agent2d-3.1.1.tar.gz
tar -xf agent2d-3.1.1.tar.gz
cd agent2d-3.1.1
sudo ./configure
sudo make

cd $home
echo "Installing UvA Trilearn"
#wget http://inf.ufes.br/~pet/projetos/Simulação_2D/Sim2D/trilearn_base_sources-3.3-v13-by_PET.tar.gz
tar -xf trilearn_base_sources-3.3-v13-by_PET.tar.gz
cd trilearn_base_sources-3.3-v13-by_PET
sudo ./configure
sudo make

echo "Installation complete"
echo "Open a new terminal instance or reload terminal (source ~/.bashrc) to apply changes"
echo "Run fix_decimal_separator(comma).sh IF your system use comma (,) instead of dot (.) as decimal separator"
