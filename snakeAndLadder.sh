#!/bin/bash

playerOnePosition=0

NO_PLAY	=1
LADDER=2
SNAKE=3
START_POSITION=0

function dieRoll() {
	number=$((RANDOM%6+1))
	echo $number
}

function getOption() {
	option=$(($((RANDOM%3))+1))
	echo $option
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
				echo "You Rolled dice of $roll position"
				echo -e "You are lucky got a ladder\nPlayer moved up to position: $playerOnePosition\n"
				;;

			$SNAKE)
				playerOnePosition=$(($playerOnePosition-$roll))
				echo "You Rolled dice of $roll position"
				echo -e "you are unlucky eaten by snake\nPlayer moved down up to position: $playerOnePosition\n"
				;;
	esac
}
