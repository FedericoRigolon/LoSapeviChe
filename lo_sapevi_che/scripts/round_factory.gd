extends Node

func create_round(round_number: int) -> Round:
	var round = preload("res://scenes/round.tscn").instantiate()
	round.setup(_create_question(round_number), GameLogic.manage_answers(_create_answers(round_number)))
	Round.increase_round_count()
	round.set_name("Round" + str(Round.get_round_count()))
	return round

func _create_question(round_number: int) -> Question:
	var question = preload("res://scenes/question.tscn").instantiate()
	match round_number:
		0:
			question.setup("tung tung tung tung tung tung tung tung tung sahur")
		1:
			question.setup("bombardino crocodilo")
		2:
			question.setup("trallallero trallalla")
		3:
			question.setup("brr brr patapim")
		4:
			question.setup("scimpanzini bananini")
		_:
			return null
	return question

func _create_correct_answer(text: String) -> RightAnswer:
	var answer = preload("res://scenes/answer.tscn").instantiate()
	answer.set_script(preload("res://scripts/right_answer.gd"))
	answer.setup(text)
	return answer

func _create_wrong_answer(text: String) -> WrongAnswer:
	var answer = preload("res://scenes/answer.tscn").instantiate()
	answer.set_script(preload("res://scripts/wrong_answer.gd"))
	answer.setup(text)
	return answer

func _create_answers(round_number: int) -> Array[Answer]:
	var answers: Array[Answer]
	match round_number:
		0:
			answers.append(_create_correct_answer("a"))
			answers.append(_create_wrong_answer("b"))
			answers.append(_create_wrong_answer("c"))
		1:
			answers.append(_create_correct_answer("d"))
			answers.append(_create_wrong_answer("e"))
			answers.append(_create_wrong_answer("f"))
		2:
			answers.append(_create_correct_answer("a"))
			answers.append(_create_wrong_answer("b"))
			answers.append(_create_wrong_answer("c"))
		3:
			answers.append(_create_correct_answer("d"))
			answers.append(_create_wrong_answer("e"))
			answers.append(_create_wrong_answer("f"))
		4:
			answers.append(_create_correct_answer("a"))
			answers.append(_create_wrong_answer("b"))
			answers.append(_create_wrong_answer("c"))
		_:
			push_error("Unexistent round")
	return answers
