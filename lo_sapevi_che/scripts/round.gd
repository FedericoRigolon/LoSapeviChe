extends Control

class_name Round

static var _round_count: int
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

static func increase_round_count() -> void:
	_round_count += 1
	
static func get_round_count() -> int:
	return _round_count

func _set_question(question: Question) -> void:
	self._question = question
	add_child(question)

func _set_answers(Answers: Array[Answer]) -> void:
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
		GameLogic.answer_chosen(true, _question.get_score())
	else:
		_Answers[_correct_answer_ix].highlight()
		GameLogic.answer_chosen(false, _question.get_score())
