extends Node
class_name DataManager

const DATA_PATH = "res://data/data_quiz.csv"
var seeks : Array[int]

func reset_seeks():
	self.seeks.clear()

func get_seeks():
	return self.seeks
	
func seeks_setup() -> bool:
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
	if float(GameLogic.MAX_ROUND * (GameLogic.MAX_ROUND - 1)) > -2 * size * log(0.9):
		var array = []
		for i in size:
			array.append(i)
		array.shuffle()
		# rows to pick
		row_indices = array.slice(0, GameLogic.MAX_ROUND)
	# low probability of ripetition or big array --> pick random
	else:
		for i in GameLogic.MAX_ROUND:
			var el = randi_range(0, size - 1)
			while el in row_indices:
				el = randi_range(0, size - 1)
			row_indices.append(el)
	
	var i = 0
	for row in row_indices:
		self.seeks.append(offsets[row])
	
	return true

func read_csv(seek_position: int, separator = ","):
	var data : Dictionary
	var attributes : PackedStringArray
	var file := FileAccess.open(self.DATA_PATH, FileAccess.READ)
	
	file.seek(seek_position)
	attributes = file.get_line().split(separator)
	
	var answers : Array
	for i in range(2, attributes.size()):
		answers.append(attributes[i]) 
	data["question"] = attributes[1]
	data["answers"] = answers
	
	return data
