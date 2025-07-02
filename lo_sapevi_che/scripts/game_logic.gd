const MAX_SCORE = 5

var _score: int

func _ready() -> void:
	_score = 0

func _check_answers(Answers: Array[Answer]) -> void:
	var one_correct = false
	var n = Answers.size()
	for i in range(n):
		if Answers[i] is RightAnswer:
			if not one_correct:
				one_correct = true
			else:
				push_error("There must be exactly one correct answer")
	if not one_correct:
		push_error("There must be exactly one correct answer")

func _shuffle_answers(Answers: Array[Answer]) -> Array[Answer]:
	var shuffled = Answers.duplicate()
	var n = shuffled.size()
	for i in range(n - 1, 0, -1):
		var j = randi() % (i + 1)
		var tmp = shuffled[i]
		shuffled[i] = shuffled[j]
		shuffled[j] = tmp
	return shuffled

func manage_answers(Answers: Array[Answer]) -> Array[Answer]:
	_check_answers(Answers)
	return _shuffle_answers(Answers)

func answer_chosen(correct: bool, score: int) -> void:
	if correct:
		self._score += _score

func get_score() -> int:
	return self._score
