extends Node



func _on_menu_play_pressed() -> void:
	print("scimpanzini bananini")
	const ROUNDS = 5
	for r in range(ROUNDS):
		var round = round_factory(r)
		add_child(round)
		#await roba
		#remove_child(round)
		#round.queue_free()

func round_factory(round_number):
	
	var lambda_question = func() -> Question:
		var question = preload("res://scenes/question.tscn").instantiate()
		match round_number:
			1:
				return question.setup()
			2:
				return question.setup()
			3:
				return question.setup()
			4:
				return question.setup()
			5:
				return question.setup()
			_:
				return null
		return question
	
	var lambda_answers = func() -> Array[Answer]:
			var answers: Array[Answer]
			var answer = preload("res://scenes/answer.tscn").instantiate()
			
			var correct_answer = func(text: String) -> void:
				answer.set_script(preload("res://scripts/right_answer.gd"))
				answer.setup(text)
				answers.append(answer)
				
			var wrong_answers = func(texts: Array[String]) -> void:
				answer.set_script(preload("res://scripts/wrong_answer.gd"))
				for text in texts:
					answer.setup(text)
					answers.append(answer)
			
			var make_answer = func() -> void:
				match round_number:
					1:
						correct_answer.call("a")
						wrong_answers.call(["b", "c", "d"] as Array[String])
					2:
						correct_answer.call("a")
						wrong_answers.call(["b", "c", "d"] as Array[String])
					3:
						correct_answer.call("a")
						wrong_answers.call(["b", "c", "d"] as Array[String])
					4:
						correct_answer.call("a")
						wrong_answers.call(["b", "c", "d"] as Array[String])
					5:
						correct_answer.call("a")
						wrong_answers.call(["b", "c", "d"] as Array[String])
					_:
						return
			
			make_answer.call()
			return answers
	
	var round = preload("res://scenes/round.tscn").instantiate()
	round.setup(lambda_question.call(), lambda_answers.call())
	return round
	
