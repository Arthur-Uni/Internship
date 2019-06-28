#!/bin/bash

ffmpeg -i ROCK.mp4 -c copy -an ROCK_noSound.mp4
ffmpeg -i PAPER.mp4 -c copy -an PAPER_noSound.mp4
ffmpeg -i SCISSORS.mp4 -c copy -an SCISSORS_noSound.mp4
ffmpeg -i ILLEGAL.mp4 -c copy -an ILLEGAL_noSound.mp4

