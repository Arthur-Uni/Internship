#!/bin/bash

SCRIPTPATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
echo $SCRIPTPATH

mkdir $1

ROOTPATH=$SCRIPTPATH/$1

cd $ROOTPATH
mkdir ROCK
mkdir PAPER
mkdir SCISSORS
mkdir ILLEGAL

cd ROCK
mkdir DATA
mkdir VIDEO

cd $ROOTPATH
cd PAPER
mkdir DATA
mkdir VIDEO

cd $ROOTPATH
cd SCISSORS
mkdir DATA
mkdir VIDEO

cd $ROOTPATH
cd ILLEGAL
mkdir DATA
mkdir VIDEO
