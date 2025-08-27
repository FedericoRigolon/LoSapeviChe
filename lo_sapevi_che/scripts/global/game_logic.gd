## Singleton script that contains main logic of the game. It manages what happens after user
## interactions and how to end the game.
extends Node  # needed for autoload (singleton)

## Emitted when the answer is wrong.
signal wrong_answer

## Max number of rounds in the game.
var MAX_ROUND

## NUmber of correct answers given.
var _correct_answer: int = 0

## Current score.
var _score: int = 0

## Max score.
var _max_score: int = 0


## Setups variable, Max round in particular.
func _ready() -> void:
	MAX_ROUND = DataManager.get_max_rounds()


## Getter for max round.
func get_max_round() -> int:
	return MAX_ROUND


## Checks if a group of answers contains exactly one correct, returns true or false.
func _check_answers(answers: Array[Answer]) -> bool:
	var one_correct = false
	var n = answers.size()
	for i in range(n):
		if answers[i] is RightAnswer:
			if not one_correct:
				one_correct = true
			else:
				push_error("There must be exactly one correct answer")
				return false
	if not one_correct:
		push_error("There must be exactly one correct answer")
		return false
	return true


## Shuffles the answers order.
func manage_answers(answers: Array[Answer]) -> Array[Answer]:
	if _check_answers(answers):
		answers.shuffle()
		return answers
	else:
		return []


## Checks if the anwer given is correct or not. Plays sound and emits signal.
func answer_chosen(answer: Answer, score: int) -> void:
	if answer is RightAnswer:
		self._score += score
		self._correct_answer += 1
		AudioManager.correct()
	else:
		AudioManager.wrong()
		self.wrong_answer.emit()


## Return the index of correct answer.
func get_correct_answer_ix(answers: Array[Answer]) -> int:
	var n = answers.size()
	for i in range(n):
		if answers[i] is RightAnswer:
			return i
	return -1


## Getter for score.
func get_score() -> int:
	return self._score


## Updates the max score.
func increase_max_score(score: int) -> void:
	self._max_score += score


## Getter for max score.
func get_max_score() -> int:
	return self._max_score


## Getter for correct answer.
func get_correct_answer() -> int:
	return self._correct_answer


## Checks if the user won. There are 2 types of win: 100% or 51%,
## this method only checks if the user didin't lose.
func win() -> bool:
	return self._score >= (self._max_score / 2 + 1)


## Checks the 100% win, it's called only after 51% win is confirmed.
func perfect_win() -> bool:
	return self._score >= self._max_score
	

## Resets every attribute, called after game restart.
func reset() -> void:
	self._score = 0
	self._max_score = 0
	self._correct_answer = 0
