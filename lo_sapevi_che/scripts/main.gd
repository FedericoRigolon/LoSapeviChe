extends Node



func _on_menu_play_pressed() -> void:
	print("scimpanzini bananini")
	const ROUNDS = 5
	for round in range(ROUNDS):
		round_factory(round)

func round_factory(round_number):
	
	var lambda_question = func() -> Question:
		var question : Question = null
		match round_number:
			1:
				return question.new()
			2:
				return question.new()
			3:
				return question.new()
			4:
				return question.new()
			5:
				return question.new()
			_:
				return null
	
	var lambda_answers = func() -> Array[Answer]:
			var answers: Array[Answer]
		
			var correct_answer = func(text: String) -> void:
				answers.append(RightAnswer.new().inizialize(text))
				
			var wrong_answers = func(texts: Array[String]) -> void:
				for text in texts:
					answers.append(WrongAnswer.new().inizialize(text))
			
			var make_answer = func() -> void:
				match round_number:
					1:
						correct_answer.call("a")
						wrong_answers.call("b")
					2:
						correct_answer.call("a")
						wrong_answers.call("b")
					3:
						correct_answer.call("a")
						wrong_answers.call("b")
					4:
						correct_answer.call("a")
						wrong_answers.call("b")
					5:
						correct_answer.call("a")
						wrong_answers.call("b")
					_:
						return
			
			make_answer.call()
			return answers
	
	var round = preload("res://scenes/round.tscn").instantiate()
	round.setup(lambda_question.call(), lambda_answers.call())
	Round.round_count += 1
	return round
	
