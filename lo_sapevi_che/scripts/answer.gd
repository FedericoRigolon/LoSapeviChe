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

func _set_sound(path_to_sound: String) -> void:
	var sound = load(path_to_sound)
	if sound is AudioStream:
		$AnswerSound.set_stream(sound)

func highlight() -> void:
	push_error("highligth() must be overridden in subclasses.") # simule abstract class

func _play_sound() -> void:
	var sound = $AnswerSound
	if sound.get_stream():
		sound.play()

func on_answer_chosen() -> void:
	highlight()
	_play_sound()

func _on_pressed() -> void:
	self.answer_clicked.emit(self)
