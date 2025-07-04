extends Node	# needed for autoload (singleton)

signal wrong_answer

const MAX_ROUND = 5

var _correct_answer: int = 0
var _score: int = 0
var _max_score: int = 0

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

func _shuffle_answers(answers: Array[Answer]) -> Array[Answer]:
	var shuffled = answers.duplicate()
	var n = shuffled.size()
	for i in range(n - 1, 0, -1):
		var j = randi() % (i + 1)
		var tmp = shuffled[i]
		shuffled[i] = shuffled[j]
		shuffled[j] = tmp
	return shuffled

func manage_answers(answers: Array[Answer]) -> Array[Answer]:
	if(_check_answers(answers)):
		return _shuffle_answers(answers)
	else:
		return []

func answer_chosen(answer: Answer, score: int) -> void:
	if answer is RightAnswer:
		self._score += score
		self._correct_answer += 1
	else:
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
