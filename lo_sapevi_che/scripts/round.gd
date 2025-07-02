extends Control

class_name Round

signal answer_chosen

static var round_count: int
var _question: Question
var _Answers: Array[Answer]
var _correct_answer_ix: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(question: Question, Answers: Array[Answer]) -> void:
	_set_question(question)
	_set_answers(Answers)
	for answer in self._Answers:
		answer.connect_to_parent()

func increase_round_count() -> void:
	round_count += 1
	
func get_round_count() -> int:
	return round_count

func _set_question(question: Question) -> void:
	self._question = question
	add_child(question)

func _check_answers(Answers: Array[Answer]) -> bool:
	var one_correct = false
	var n = Answers.size()
	for i in range(n):
		if Answers[i] is RightAnswer:
			if not one_correct:
				one_correct = true
			else:
				push_error("There must be exactly one correct answer")
				return false
	if not one_correct:
		push_error("There must be exactly one correct answer")
		return false
	return true

func _shuffle_answers(Answers: Array[Answer]) -> Array[Answer]:
	var shuffled = Answers.duplicate()
	var n = shuffled.size()
	for i in range(n - 1, 0, -1):
		var j = randi() % (i + 1)
		var tmp = shuffled[i]
		shuffled[i] = shuffled[j]
		shuffled[j] = tmp
	return shuffled

func _set_answers(Answers: Array[Answer]) -> void:
	if _check_answers(Answers):
		Answers = _shuffle_answers(Answers)
		self._Answers = Answers
		var n = Answers.size()
		for i in range(n):
			add_child(Answers[i])
			if _Answers[i] is RightAnswer:
				self._correct_answer_ix = i

func _disconnect_answers() -> void:
	for answer in self._Answers:
		answer.disconnect_to_parent()

func _on_answer_clicked(answer: Answer) -> void:
	_disconnect_answers()
	answer.on_answer_chosen()
	if answer is RightAnswer:
		self.answer_chosen.emit(true, _question.get_score())
	else:
		_Answers[_correct_answer_ix].highlight()
		self.answer_chosen.emit(false, _question.get_score())
