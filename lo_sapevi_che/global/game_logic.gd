extends Node	# needed for autoload (singleton)

const MAX_SCORE = 5

signal wrong_answer

var _score: int = 0

func _check_answers(answers: Array[Answer]) -> void:
	var one_correct = false
	var n = answers.size()
	for i in range(n):
		if answers[i] is RightAnswer:
			if not one_correct:
				one_correct = true
			else:
				push_error("There must be exactly one correct answer")
	if not one_correct:
		push_error("There must be exactly one correct answer")

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
	_check_answers(answers)
	return _shuffle_answers(answers)

func answer_chosen(answer: Answer, score: int) -> void:
	if answer is RightAnswer:
		self._score += score
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
