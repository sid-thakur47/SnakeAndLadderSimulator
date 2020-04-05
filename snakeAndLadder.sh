#!/bin/bash
declare -A dict

diceCount=0
dictMultiPlayer[player1]=0
dictMultiPlayer[player2]=0

NO_PLAY=1
LADDER=2
SNAKE=3
START_POSITION=0
WIN_POSITION=100

function getPlayerTurn() {
	if [ $(($diceCount%2)) -eq 0 ]
	then
		echo "Player1 Turn"
		player=player1
	else
		echo "Player2 Turn"
		player=player2
	fi
	diceCount=$(($diceCount+1))
	echo "Current position of $player is ${dictMultiPlayer[$player]}"
}

function continueTillPlayerWins() {
	for (( ;; ))
	do
		getPlayerTurn
		checkOption
		if [ ${dictMultiPlayer[$player]} -eq $WIN_POSITION ]
		then
			echo "$player wins the game"
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
	if [ ${dictMultiPlayer[$player]} -lt $START_POSITION ]
	then
		echo "You moved to position 0 $player restarts from 0"
		dictMultiPlayer[$player]=$START_POSITION
	fi
}
function stayInPreviousPosition() {
	if [[ ${dictMultiPlayer[$player]} -ge $WIN_POSITION+1 ]]
	then
		dictMultiPlayer[$player]=$((${dictMultiPlayer[$player]}-$roll))
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
				dictMultiPlayer[$player]=$((${dictMultiPlayer[$player]}+$roll))
				stayInPreviousPosition
				echo "You Rolled dice of $roll position"
				echo -e "You are lucky got a ladder\nPlayer moved up to position ${dict[$player]}\n"
				;;

			$SNAKE)
				dictMultiPlayer[$player]=$((${dictMultiPlayer[$player]}-$roll))
				restartGame
				echo "You Rolled dice of $roll position"
				echo -e "you are unlucky eaten by snake\nPlayer moved down up to position ${dict[$player]}\n "
				;;
		esac
}
continueTillPlayerWins
