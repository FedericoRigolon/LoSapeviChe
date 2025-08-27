## This class represents a wrong answer. It extends answer.
extends Answer
class_name WrongAnswer

## Color green.
const HIGHLIGHT_COLOR = Color(1.0, 0.3, 0.0, 1.0)  # red


## Override of setup. Simply calls the parent method.
func setup(text: String) -> void:
	super.setup(text)


## Override of highlight, it changes the color to green.
func highlight() -> void:
	self.self_modulate = HIGHLIGHT_COLOR
