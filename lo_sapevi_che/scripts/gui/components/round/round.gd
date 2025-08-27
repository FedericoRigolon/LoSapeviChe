## This class represents a round object.
extends Control

class_name Round

## Emitted when this object has to be killed.
signal kill_me

## Number of rounds created.
static var _round_count: int

## Every round has one question.
var _question: Question

## Every round has an array of answer (2 wrong and 1 correct).
var _answers: Array[Answer]


## Sets the visibility to 1.0
func _ready() -> void:
	self.modulate.a = 1.0


## Setups question, answers and connects signals.
func setup(question: Question, answers: Array[Answer]) -> void:
	_set_question(question)
	_set_answers(answers)
	for answer in self._answers:
		answer.connect_to_parent()
	GameLogic.wrong_answer.connect(_on_wrong_answer)


## Updates round_count. Called every time a round is created.
static func increase_round_count() -> void:
	_round_count += 1


## Getter for round count.
static func get_round_count() -> int:
	return _round_count


## Resets the round count. Called when game restarts.
static func reset_round_count() -> void:
	_round_count = 0


## Sets the question attribute with the given question object.
func _set_question(question: Question) -> void:
	self._question = question
	#if Round.get_round_count() == 1:
	#	await
	add_child(question)


## Sets the answer attribute with the given answers object.
func _set_answers(answers: Array[Answer]) -> void:
	self._answers = answers
	for answer in answers:
		add_child(answer)
		if has_node("GreenKid"):
			move_child($GreenKid, -1)


## Getter for question.
func get_question() -> Question:
	return self._question


## Shows every answer and plays an entrance animation.
func _display_answers() -> void:
	var n = _answers.size()
	for i in range(n):
		_answers[i].position.y += (_answers[i].size.y + 20) * i
	for ans in self._answers:
		$AnswersAnimation.set_target_node(ans)
		$AnswersAnimation.start()


## Disconnects every answer from signals.
func _disconnect_answers() -> void:
	for answer in self._answers:
		answer.disconnect_to_parent()
		answer.disconnect_click()


## Called on round start. It shows the answer after awaiting a frame.
func start():
	await get_tree().process_frame
	_display_answers()


## Called after user click on answer. It highlights with green or red
## the answer chosen and plays an exit animation.
func _on_answer_clicked(answer: Answer) -> void:
	$Question.kill()
	_disconnect_answers()
	answer.on_answer_chosen()
	GameLogic.answer_chosen(answer, _question.get_score())
	for ans in _answers:
		$AnswersAnimation.set_target_node(ans)
		$AnswersAnimation.start(2.0, false)


## Gets the index of right answer and highlights it.
## When user click on wrong answer, both wrong and correct answers are highlighted.
func _on_wrong_answer() -> void:
	_answers[GameLogic.get_correct_answer_ix(_answers)].highlight()


## After exit animation the kill me signal is emitted.
func _on_exit_tween_animation_done() -> void:
	self.kill_me.emit()


## On tree entered the visibility is changed and the round can start.
## The first start must be called from gui (round container).
func _on_tree_entered() -> void:
	# the first start has to be called from gui (round container)
	if Round.get_round_count() > 1:
		$Question.visible = true
		start()
