#!/bin/bash
playerOnePosition=0

START_POSITION=0

function dieRoll() {
	number=$((RANDOM%6+1))
	echo $number
}
dieRoll