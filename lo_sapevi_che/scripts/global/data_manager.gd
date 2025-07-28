extends Node
class_name DataManager

const DATA_PATH = "res://data/data_quiz.csv"
var seeks: Array[int]


static func get_max_rounds():
	var file = FileAccess.open(DATA_PATH, FileAccess.READ)
	var rounds = file.get_line().to_int()
	file.close()

	return rounds


func reset_seeks():
	self.seeks.clear()


func get_seeks():
	return self.seeks


func seeks_setup() -> bool:
	var file := FileAccess.open(self.DATA_PATH, FileAccess.READ)

	if file == null:
		push_error("Cant open CSV file: %s" % self.DATA_PATH)
		return false

	# first row is MAX ROUND
	file.get_line()

	var offsets: Array
	var size = 0
	while not file.eof_reached():
		size += 1
		offsets.append(file.get_position())
		file.get_line()
	size -= 1
	offsets.pop_back()

	file.close()

	var row_indices: Array
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
	var data: Dictionary
	var attributes: PackedStringArray
	var file := FileAccess.open(self.DATA_PATH, FileAccess.READ)

	file.seek(seek_position)
	var raw_line := file.get_line()

	attributes = _parse_csv_line(raw_line, separator)

	var answers: Array
	for i in range(2, attributes.size()):
		answers.append(attributes[i])
	data["question"] = attributes[1]
	data["answers"] = answers

	return data


func _parse_csv_line(line: String, separator: String = ",") -> Array:
	var result: Array = []
	var current = ""
	var inside_quotes = false

	for i in line.length():
		var char := line[i]

		if char == '"' and (i == 0 or line[i - 1] != "\\"):  # Toggle quote mode
			inside_quotes = not inside_quotes
		elif char == separator and not inside_quotes:
			var cleaned = current.strip_edges()
			cleaned = cleaned.lstrip('"').rstrip('"')
			result.append(cleaned)
			current = ""
		else:
			current += char

	# Add the last element
	var cleaned = current.strip_edges()
	cleaned = cleaned.lstrip('"').rstrip('"')
	result.append(cleaned)

	return result
