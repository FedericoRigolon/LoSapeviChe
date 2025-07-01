extends Answer

class_name RightAnswer

const HIGHLIGHT_COLOR = Color(0, 1, 0, 1) # green

func inizialize(text) -> RightAnswer:
	super.inizialize(text)
	_set_sound("res://art/sounds/right.mp3")
	return self

func _highlight() -> void:
	self.modulate = HIGHLIGHT_COLOR
