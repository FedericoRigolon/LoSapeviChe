extends Button

class_name Answer

signal answer_clicked

func setup(text: String) -> void:
	_set_text(text)
	pressed.connect(_on_pressed)

func connect_to_parent() -> void:
	self.answer_clicked.connect(get_parent()._on_answer_clicked)

func disconnect_to_parent() -> void:
	self.answer_clicked.disconnect(get_parent()._on_answer_clicked)

func disconnect_click() -> void:
	self.disabled = true

func _set_text(text: String) -> void:
	$Text.set_text(text)

func _get_text() -> String:
	return $Text.get_text()

func highlight() -> void:
	push_error("highligth() must be overridden in subclasses.") # simule abstract class

func on_answer_chosen() -> void:
	highlight()

func _on_pressed() -> void:
	self.answer_clicked.emit(self)
