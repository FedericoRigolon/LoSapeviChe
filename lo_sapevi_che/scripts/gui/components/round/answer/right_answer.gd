## This class represents a correct answer. It extends answer.
extends Answer

class_name RightAnswer

## Color green.
const HIGHLIGHT_COLOR = Color(0.2, 1.0, 0.0, 1.0)  # green


## Override of setup. Simply calls the parent method.
func setup(text: String) -> void:
	super.setup(text)


## Override of highlight, it changes the color to green.
func highlight() -> void:
	self.self_modulate = HIGHLIGHT_COLOR
