extends Answer

class_name RightAnswer

const HIGHLIGHT_COLOR = Color(0, 1, 0, 1) # green

func setup(text):
	super.setup(text)
	_set_sound("res://art/sounds/right.mp3")

func highlight() -> void:
	self.modulate = HIGHLIGHT_COLOR
