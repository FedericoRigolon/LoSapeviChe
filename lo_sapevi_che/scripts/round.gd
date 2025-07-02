extends Control

class_name Round

signal finished

static var _round_count: int
var _question: Question
var _answers: Array[Answer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(question: Question, answers: Array[Answer]) -> void:
	_set_question(question)
	_set_answers(answers)
	_display_answers()
	for answer in self._answers:
		answer.connect_to_parent()
	GameLogic.wrong_answer.connect(_on_wrong_answer)

static func increase_round_count() -> void:
	_round_count += 1
	
static func get_round_count() -> int:
	return _round_count

func _set_question(question: Question) -> void:
	self._question = question
	add_child(question)

func _set_answers(answers: Array[Answer]) -> void:
		self._answers = answers
		for answer in answers:
			add_child(answer)

func _display_answers() -> void:
	var n = _answers.size()
	for i in range(n):
		_answers[i].position.y += (_answers[i].size.y + 10) * i

func _disconnect_answers() -> void:
	for answer in self._answers:
		answer.disconnect_to_parent()

func _on_answer_clicked(answer: Answer) -> void:
	_disconnect_answers()
	answer.on_answer_chosen()
	GameLogic.answer_chosen(answer, _question.get_score())
	await get_tree().create_timer(2.0).timeout 
	_finished()

func _on_wrong_answer() -> void:
	_answers[GameLogic.get_correct_answer_ix(_answers)].highlight()

func _finished() -> void:
	self.finished.emit()
