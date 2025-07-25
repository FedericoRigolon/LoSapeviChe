extends Node	# needed for autoload (singleton)

signal wrong_answer

var MAX_ROUND

var _correct_answer: int = 0
var _score: int = 0
var _max_score: int = 0

func _ready() -> void:
	MAX_ROUND = RoundFactory.get_max_rounds()
	
func get_max_round() -> int:
	return MAX_ROUND
	
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

func manage_answers(answers: Array[Answer]) -> Array[Answer]:
	if(_check_answers(answers)):
		answers.shuffle()
		return answers
	else:
		return []

func answer_chosen(answer: Answer, score: int) -> void:
	if answer is RightAnswer:
		self._score += score
		self._correct_answer += 1
		AudioManager.correct()
	else:
		AudioManager.wrong()
		self.wrong_answer.emit()

func get_correct_answer_ix(answers: Array[Answer]) -> int:
	var n = answers.size()
	for i in range(n):
		if answers[i] is RightAnswer:
			return i
	return -1 

func get_score() -> int:
	return self._score

func increase_max_score(score: int) -> void:
	self._max_score += score

func get_max_score() -> int:
	return self._max_score

func get_correct_answer() -> int:
	return self._correct_answer

func win() -> bool:
	return self._score >= self._max_score

func reset() -> void:
	self._score = 0
	self._max_score = 0
	self._correct_answer = 0
