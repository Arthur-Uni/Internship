#!/bin/bash

#pre-checks
if [ -z $1 ] || [ -z $2 ]
then
	echo "2 parameters are needed for this script:"
	echo "1: recording length (in milliseconds)"
	echo "2: convert video to images every x seconds"
	echo "Please provide the necessary number of input parameters for this script:"
	echo "./convert.sh -recording_length -x"
	echo "Exiting..."
	exit
fi

#define all necessary paths and create directories
SCRIPTPATH="$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
echo $SCRIPTPATH

echo "Enter subject name please: "
read SUBJECT
echo "Subject name is $SUBJECT"
#check if folder for the current subject is already present
if [ ! -d "$SUBJECT" ]
then
	mkdir $SUBJECT	
fi

ROOTPATH=$SCRIPTPATH/$SUBJECT
echo $ROOTPATH
cd $ROOTPATH

echo "Enter type of class to be recorded (ROCK, PAPER, SCISSORS, ILLEGAL)"
read CLASS
echo "Recorded class is $CLASS"
mkdir $CLASS
CLASSPATH=$ROOTPATH/$CLASS
echo $CLASSPATH
cd $CLASSPATH

mkdir VIDEO
VIDEOPATH=$CLASSPATH/VIDEO
cd $VIDEOPATH
echo "Get ready..."
read -n 1 -s -r -p "Press any key to continue"
sleep 1

#record video
raspivid -t $1 -w 640 -h 480 -fps 25 -b 1200000 -p 0,0,1280,720 -o $CLASS.h264

#convert h264 to mp4 format
ffmpeg -framerate 25 -i $VIDEOPATH/$CLASS.h264 -c copy $VIDEOPATH/$CLASS.mp4

#check, if previous command was successful
return_value=$?
if [ $return_value -ne 0 ]
then
	echo "Video conversion was not successful"
	echo "Exiting..."
	exit
fi

#extract frames from the recorded video
echo "Extracting pictures from video..."
cd $CLASSPATH
mkdir DATA
DATAPATH=$CLASSPATH/DATA
cd $DATAPATH

ffmpeg -i $VIDEOPATH/$CLASS.mp4 -vf fps=$2 $CLASS%04d.jpg
