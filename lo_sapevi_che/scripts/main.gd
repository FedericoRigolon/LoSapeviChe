extends Node



func _on_menu_play_pressed() -> void:
	#print("scimpanzini bananini")
	const ROUNDS = 1
	for r in range(ROUNDS):
		var round = round_factory(r)
		add_child(round)
	print_tree_pretty()
		#await roba
		#remove_child(round)
		#round.queue_free()

func round_factory(round_number):
	
	var lambda_question = func() -> Question:
		var question = preload("res://scenes/question.tscn").instantiate()
		match round_number:
			0:
				question.setup()
				question.set_text("tuuuuuuuuuuuuung")
			1:
				question.setup()
			2:
				question.setup()
			3:
				question.setup()
			4:
				question.setup()
			_:
				return null
		print(question)
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
					0:
						correct_answer.call("a")
						wrong_answers.call(["b", "c", "d"] as Array[String])
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
					_:
						return
			
			make_answer.call()
			return answers
	
	var round = preload("res://scenes/round.tscn").instantiate()
	round.setup(lambda_question.call(), lambda_answers.call())
	Round.round_count += 1
	round.set_name("Round"+str(Round.round_count))
	return round
	
