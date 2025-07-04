extends Node

const DATA_PATH = "res://data/question_answer.csv"
const MAX_ROUND = 5
var seeks : Array[int]

func _ready():
	if not seeks_setup():
		return

func reload():
	self.seeks = []
	self.seeks_setup()
	
func create_round(round_number: int) -> Round:
	var round = preload("res://scenes/round.tscn").instantiate()
	var data : Dictionary = _read_csv(self.seeks[round_number])
	round.setup(_create_question(data["question"], data["value"]), GameLogic.manage_answers(_create_answers(data["answers"])))
	Round.increase_round_count()
	round.set_name("Round" + str(Round.get_round_count()))
	return round

func seeks_setup() -> bool :
	var file := FileAccess.open(self.DATA_PATH, FileAccess.READ)
	
	if file == null:
		push_error("Cant open CSV file: %s" % self.DATA_PATH)
		return false
	
	var offsets : Array
	var size = 0
	while not file.eof_reached():
		size += 1
		offsets.append(file.get_position())
		file.get_line()
	size -= 1
	offsets.pop_back()
	
	
	var row_indices : Array
	# this formula takes n (total elements) and k (elements to pick up) and chose the most efficient algorithm
	# high probability of ripetition or low size --> shuffle array
	if float(self.MAX_ROUND * (self.MAX_ROUND - 1)) > -2 * size * log(0.9):
		var array = []
		for i in size:
			array.append(i)
		array.shuffle()
		# rows to pick
		row_indices = array.slice(0, self.MAX_ROUND)
		print(row_indices)
	# low probability of ripetition or big array --> pick random
	else:
		for i in self.MAX_ROUND:
			var el = randi_range(0, size - 1)
			while el in row_indices:
				el = randi_range(0, size - 1)
			row_indices.append(el)
	
	var i = 0
	for row in row_indices:
		self.seeks.append(offsets[row])
	
	return true

func _read_csv(seek_position: int):
	var data : Dictionary
	var attributes : PackedStringArray
	var file := FileAccess.open(self.DATA_PATH, FileAccess.READ)
	
	file.seek(seek_position)
	attributes = file.get_line().split(",")
	
	var answers : Array
	for i in range(2, attributes.size()):
		answers.append(attributes[i]) 
	data["question"] = attributes[0]
	data["value"] = attributes[1] as int
	data["answers"] = answers
	
	return data
	
func _create_question(text: String, value: int) -> Question:
	var question = preload("res://scenes/question.tscn").instantiate()
	question.setup(text, value)
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

func _create_answers(answers_text: PackedStringArray) -> Array[Answer]:
	var answers: Array[Answer]
	answers.append(_create_correct_answer(answers_text[0]))
	answers.append(_create_wrong_answer(answers_text[1]))
	answers.append(_create_wrong_answer(answers_text[2]))
	return answers
