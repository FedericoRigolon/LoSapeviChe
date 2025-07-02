extends Control

class_name Round

var _question: Question
var _Answers: Array[Answer]
var _correct_answer_ix: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(question: Question, Answers: Array[Answer]):
	_cleaner()
	_set_question(question)
	_set_answers(Answers)
	for answer in self._Answers:
		answer.connect_to_target(self)

func _set_question(question: Question):
	self._question = question

func _set_answers(Answers: Array[Answer]):
	var one_correct = false
	for i in range(Answers.size()):
		if Answers[i] is RightAnswer:
			if not one_correct:
				one_correct = true
			else:
				push_error("There must be exactly one correct answer")
	if not one_correct:
		push_error("There must be exactly one correct answer")
	self._Answers = Answers

func _cleaner():
	pass

func _disconnect_answers():
	for answer in self._Answers:
		answer.disconnect_to_target(self)

func _on_answer_clicked():
	_disconnect_answers()
