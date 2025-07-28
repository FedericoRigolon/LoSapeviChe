extends DataManager


func reset():
	super.reset_seeks()
	Round.reset_round_count()


func start():
	super.seeks_setup()


func create_round(round_number: int) -> Round:
	var round = preload("res://scenes/components/round.tscn").instantiate()
	var data: Dictionary = super.read_csv(super.get_seeks()[round_number])
	round.setup(
		_create_question(data["question"]),
		GameLogic.manage_answers(_create_answers(data["answers"]))
	)
	GameLogic.increase_max_score(round.get_question().get_score())
	Round.increase_round_count()
	round.set_name("Round" + str(Round.get_round_count()))
	return round


func _create_question(text: String) -> Question:
	var question = preload("res://scenes/components/buttons/question.tscn").instantiate()
	question.setup(text)
	return question


func _create_correct_answer(text: String) -> RightAnswer:
	var answer = preload("res://scenes/components/buttons/answer.tscn").instantiate()
	answer.set_script(preload("res://scripts/gui/components/round/answer/right_answer.gd"))
	answer.setup(text)
	return answer


func _create_wrong_answer(text: String) -> WrongAnswer:
	var answer = preload("res://scenes/components/buttons/answer.tscn").instantiate()
	answer.set_script(preload("res://scripts/gui/components/round/answer/wrong_answer.gd"))
	answer.setup(text)
	return answer


func _create_answers(answers_text: PackedStringArray) -> Array[Answer]:
	var answers: Array[Answer]
	answers.append(_create_correct_answer(answers_text[0]))
	answers.append(_create_wrong_answer(answers_text[1]))
	answers.append(_create_wrong_answer(answers_text[2]))
	return answers
