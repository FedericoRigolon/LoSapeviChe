extends Answer

class_name WrongAnswer

const HIGHLIGHT_COLOR = Color(1.0, 0.3, 0.0, 1.0)  # red


func setup(text: String) -> void:
	super.setup(text)


func highlight() -> void:
	self.self_modulate = HIGHLIGHT_COLOR
