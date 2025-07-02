extends Control
class_name Round

static var round_count: int
var question: Question
var answers: Array[Answer]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(question: Question, answers: Array[Answer]):
	
	_cleaner()

func _cleaner():
	pass
	

	
