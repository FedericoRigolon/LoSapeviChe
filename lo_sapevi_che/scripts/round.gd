extends Control

static var round_count: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func setup(question: Question, answers: Array[Answer]):
	Round.round_count += 1
	_cleaner()

func _cleaner():
	pass
	

	
