extends Answer

class_name WrongAnswer

const HIGHLIGHT_COLOR = Color(1, 0, 0, 1) # red

func inizialize(text) -> WrongAnswer:
	super.inizialize(text)
	_set_sound("res://art/sounds/wrong.mp3")
	return self

func _highlight() -> void:
	self.modulate = HIGHLIGHT_COLOR
