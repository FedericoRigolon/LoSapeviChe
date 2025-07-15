extends Answer

class_name RightAnswer

const HIGHLIGHT_COLOR = Color(0.2, 1.0, 0.0, 1.0) # green

func setup(text: String) -> void:
	super.setup(text)
	_set_sound("res://art/sounds/right.mp3")

func highlight() -> void:
	self.self_modulate = HIGHLIGHT_COLOR
