extends Answer

class_name WrongAnswer

const HIGHLIGHT_COLOR = Color(1, 0, 0, 1) # red

func setup(text: String) -> void:
	super.setup(text)
	_set_sound("res://art/sounds/wrong.mp3")

func highlight() -> void:
	self.self_modulate = HIGHLIGHT_COLOR
