extends Control

class_name Round

signal kill_me

static var _round_count: int
var _question: Question
var _answers: Array[Answer]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.modulate.a = 1.0


func setup(question: Question, answers: Array[Answer]) -> void:
	_set_question(question)
	_set_answers(answers)
	for answer in self._answers:
		answer.connect_to_parent()
	GameLogic.wrong_answer.connect(_on_wrong_answer)


static func increase_round_count() -> void:
	_round_count += 1


static func get_round_count() -> int:
	return _round_count


static func reset_round_count() -> void:
	_round_count = 0


func _set_question(question: Question) -> void:
	self._question = question
	add_child(question)


func _set_answers(answers: Array[Answer]) -> void:
	self._answers = answers
	for answer in answers:
		add_child(answer)
	if has_node("GreenKid"):
		move_child($GreenKid, -1)


func get_question() -> Question:
	return self._question


func _display_answers() -> void:
	var n = _answers.size()
	for i in range(n):
		_answers[i].position.y += (_answers[i].size.y + 20) * i
	for ans in self._answers:
		$AnswersAnimation.set_target_node(ans)
		$AnswersAnimation.start()


func _disconnect_answers() -> void:
	for answer in self._answers:
		answer.disconnect_to_parent()
		answer.disconnect_click()


func start():
	await get_tree().process_frame
	_display_answers()


func _on_answer_clicked(answer: Answer) -> void:
	$Question.kill()
	_disconnect_answers()
	answer.on_answer_chosen()
	GameLogic.answer_chosen(answer, _question.get_score())
	for ans in _answers:
		$AnswersAnimation.set_target_node(ans)
		$AnswersAnimation.start(0.5, false)


func _on_wrong_answer() -> void:
	_answers[GameLogic.get_correct_answer_ix(_answers)].highlight()


func _on_exit_tween_animation_done() -> void:
	self.kill_me.emit()


func _on_tree_entered() -> void:
	# the first start has to be called from gui (round container)
	if Round.get_round_count() > 1:
		$Question.visible = true
		start()
