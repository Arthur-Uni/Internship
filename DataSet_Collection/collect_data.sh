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

############################ start with ROCK class ##############################################

mkdir ROCK
CLASSPATH=$ROOTPATH/ROCK
echo $CLASSPATH
cd $CLASSPATH

mkdir VIDEO
VIDEOPATH=$CLASSPATH/VIDEO
cd $VIDEOPATH
echo "Get ready..."
read -n 1 -s -r -p "Press any key to continue"
sleep 0.5

#record video
raspivid -t $1 -w 640 -h 480 -fps 25 -b 1200000 -p 0,0,1280,720 -o ROCK.h264

#convert h264 to mp4 format
ffmpeg -framerate 25 -i $VIDEOPATH/ROCK.h264 -c copy $VIDEOPATH/ROCK.mp4

#check, if previous command was successful
return_value=$?
if [ $return_value -ne 0 ]
then
	echo "Video conversion was not successful"
	echo "Exiting..."
	exit
fi

#extract frames from the recorded video
echo "Extracting pictures from video for class: ROCK..."
cd $CLASSPATH
mkdir DATA
DATAPATH=$CLASSPATH/DATA
cd $DATAPATH

ffmpeg -i $VIDEOPATH/ROCK.mp4 -vf fps=$2 ROCK%04d.jpg

############################ start with PAPER class ##############################################
cd $ROOTPATH

echo "Start data acquisition for PAPER class..."
read -n 1 -s -r -p "Press any key to continue"

mkdir PAPER
CLASSPATH=$ROOTPATH/PAPER
echo $CLASSPATH
cd $CLASSPATH

mkdir VIDEO
VIDEOPATH=$CLASSPATH/VIDEO
cd $VIDEOPATH
echo "Get ready..."
read -n 1 -s -r -p "Press any key to continue"
sleep 0.5

#record video
raspivid -t $1 -w 640 -h 480 -fps 25 -b 1200000 -p 0,0,1280,720 -o PAPER.h264

#convert h264 to mp4 format
ffmpeg -framerate 25 -i $VIDEOPATH/PAPER.h264 -c copy $VIDEOPATH/PAPER.mp4

#check, if previous command was successful
return_value=$?
if [ $return_value -ne 0 ]
then
	echo "Video conversion was not successful"
	echo "Exiting..."
	exit
fi

#extract frames from the recorded video
echo "Extracting pictures from video for class: PAPER..."
cd $CLASSPATH
mkdir DATA
DATAPATH=$CLASSPATH/DATA
cd $DATAPATH

ffmpeg -i $VIDEOPATH/PAPER.mp4 -vf fps=$2 PAPER%04d.jpg
echo "Data acquisition for second class finished"

############################ start with SCISSORS class ############################################
cd $ROOTPATH

echo "Start data acquisition for SCISSORS class..."
read -n 1 -s -r -p "Press any key to continue"

mkdir SCISSORS
CLASSPATH=$ROOTPATH/SCISSORS
echo $CLASSPATH
cd $CLASSPATH

mkdir VIDEO
VIDEOPATH=$CLASSPATH/VIDEO
cd $VIDEOPATH
echo "Get ready..."
read -n 1 -s -r -p "Press any key to continue"
sleep 0.5

#record video
raspivid -t $1 -w 640 -h 480 -fps 25 -b 1200000 -p 0,0,1280,720 -o SCISSORS.h264

#convert h264 to mp4 format
ffmpeg -framerate 25 -i $VIDEOPATH/SCISSORS.h264 -c copy $VIDEOPATH/SCISSORS.mp4

#check, if previous command was successful
return_value=$?
if [ $return_value -ne 0 ]
then
	echo "Video conversion was not successful"
	echo "Exiting..."
	exit
fi

#extract frames from the recorded video
echo "Extracting pictures from video for class: SCISSORS..."
cd $CLASSPATH
mkdir DATA
DATAPATH=$CLASSPATH/DATA
cd $DATAPATH

ffmpeg -i $VIDEOPATH/SCISSORS.mp4 -vf fps=$2 SCISSORS%04d.jpg
echo "Data acquisition for third class finished"

############################ start with ILLEGAL class ############################################
cd $ROOTPATH

echo "Start data acquisition for ILLEGAL class..."
read -n 1 -s -r -p "Press any key to continue"

mkdir ILLEGAL
CLASSPATH=$ROOTPATH/ILLEGAL
echo $CLASSPATH
cd $CLASSPATH

mkdir VIDEO
VIDEOPATH=$CLASSPATH/VIDEO
cd $VIDEOPATH
echo "Get ready..."
read -n 1 -s -r -p "Press any key to continue"
sleep 0.5

#record video
raspivid -t $1 -w 640 -h 480 -fps 25 -b 1200000 -p 0,0,1280,720 -o ILLEGAL.h264

#convert h264 to mp4 format
ffmpeg -framerate 25 -i $VIDEOPATH/ILLEGAL.h264 -c copy $VIDEOPATH/ILLEGAL.mp4

#check, if previous command was successful
return_value=$?
if [ $return_value -ne 0 ]
then
	echo "Video conversion was not successful"
	echo "Exiting..."
	exit
fi

#extract frames from the recorded video
echo "Extracting pictures from video for class: ILLEGAL..."
cd $CLASSPATH
mkdir DATA
DATAPATH=$CLASSPATH/DATA
cd $DATAPATH

ffmpeg -i $VIDEOPATH/ILLEGAL.mp4 -vf fps=$2 ILLEGAL%04d.jpg
echo "Data acquisition for ILLEGAL class finished"

###################################### FINISH #####################################################
echo "Complete data acquisition finished"
