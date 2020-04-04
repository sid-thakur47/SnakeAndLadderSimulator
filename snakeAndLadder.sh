#!/bin/bash

playerOnePosition=0
diceCount=0

NO_PLAY	=1
LADDER=2
SNAKE=3
START_POSITION=0
WIN_POSITION=100

function continueTillPlayerWins() {
	for (( ;; ))
	do
		diceCount=$(($diceCount+1))
		echo "Current position of player $playerOnePosition"
		checkOption
		if [ $playerOnePosition -eq $WIN_POSITION ]
		then
			echo "Dice was rolled for: $diceCount times"
			break
		fi
	done
}

function dieRoll() {
	number=$((RANDOM%6+1))
	echo $number
}

function getOption() {
	option=$(($((RANDOM%3))+1))
	echo $option
}

function restartGame() {
	if [ $playerOnePosition -lt $START_POSITION ]
	then
		echo "You moved to position 0 player restarts from 0"
		playerOnePosition=$START_POSITION
	fi
}
function stayInPreviousPosition() {
	if [[ $playerOnePosition -ge $WIN_POSITION+1 ]]
	then
		playerOnePosition=$(($playerOnePosition-$roll))
	fi
}

function checkOption() {
	selectOption="$(getOption)"
	roll="$(dieRoll)"
		case $selectOption in
			$NO_PLAY)
				echo -e "player doesnt play\n"
				;;

			$LADDER)
				playerOnePosition=$(($playerOnePosition+$roll))
				stayInPreviousPosition
				echo "You Rolled dice of $roll position"
				echo -e "You are lucky got a ladder\nPlayer moved up to position $playerOnePosition\n"
				;;

			$SNAKE)
				playerOnePosition=$(($playerOnePosition-$roll))
				restartGame
				echo "You Rolled dice of $roll position"
				echo -e "you are unlucky eaten by snake\nPlayer moved down up to position $playerOnePosition\n "
				;;
		esac
}
continueTillPlayerWins
