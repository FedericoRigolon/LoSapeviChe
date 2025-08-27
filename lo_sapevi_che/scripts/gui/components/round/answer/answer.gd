
## This class represents an Answer. It extends a Button.
extends Button
class_name Answer


## Setups the text.
func setup(text: String) -> void:
	_set_text(text)


## Connects the parent signal relative to the answer clicked with self.
func connect_to_parent() -> void:
	self.pressed.connect(get_parent()._on_answer_clicked.bind(self))


## Disconnects the parent signal relative to the answer clicked.
func disconnect_to_parent() -> void:
	self.pressed.disconnect(get_parent()._on_answer_clicked)


## Disables button after click.
func disconnect_click() -> void:
	self.disabled = true


## Sets the text.
func _set_text(text: String) -> void:
	$Text.set_text(text)


## Getter for text.
func _get_text() -> String:
	return $Text.get_text()


## Highlights the answer (green or red). This method must be overridden in subclasse
## correct and wrong answer.
func highlight() -> void:
	push_error("highligth() must be overridden in subclasses.")  # simule abstract class


## Calls highlight method after user click on answer.
func on_answer_chosen() -> void:
	highlight()
