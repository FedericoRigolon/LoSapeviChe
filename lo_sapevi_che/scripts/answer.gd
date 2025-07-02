extends TextureRect

class_name Answer

signal answer_clicked

var _text: String
var _sound

func _ready() -> void:
	#mouse_filter = Control.MOUSE_FILTER_STOP 		FORSE SERVE PER ABILITARE I CLICK (si può fare anche da ispettore)
	pass

func inizialize(text):
	set_text(text)

func connect_to_target(receiver):
	self.answer_clicked.connect(receiver._on_answer_clicked)

func disconnect_to_target(receiver):
	self.answer_clicked.disconnect(receiver._on_answer_clicked)

func set_text(text: String):
	self._text = text

func get_text() -> String:
	return self._text

func _set_sound(path_to_sound: String) -> void:
	var sound = load(path_to_sound)
	if sound:
		self._sound = sound

func _highlight() -> void:
	push_error("_highligth() must be overridden in subclasses.") # simule abstract class

func _play_sound() -> void:
	if self._sound:
		_sound.play()

func on_answer_chosen() -> void:
	_highlight()
	_play_sound()

func _on_gui_event(event: InputEventMouseButton) -> void:
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		self.answer_clicked.emit(self)
