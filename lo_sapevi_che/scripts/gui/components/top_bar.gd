extends HBoxContainer

signal retry_pressed


func _ready():
	if AudioManager.is_audio_muted():
		_swap_audio_buttons()


func _swap_audio_buttons():
	$AudioButton.visible = not $AudioButton.visible
	$NextAudioButton.visible = not $NextAudioButton.visible

	# swap node names so that "AudioButton" is always the current one
	var audio_btn = $AudioButton
	var next_audio_btn = $NextAudioButton

	var name1 = audio_btn.name
	var name2 = next_audio_btn.name

	# nodes must not have the same name, so i need to rename it before swap
	audio_btn.set_name("tmp name")
	next_audio_btn.set_name(name2)
	audio_btn.set_name(name1)


func _on_audio_button_pressed() -> void:
	_swap_audio_buttons()
	AudioManager.toggle_audio()


func _on_retry_button_pressed() -> void:
	self.retry_pressed.emit()


func text_first_entrance() -> void:
	update_text()
	$Text.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property($Text, "modulate:a", 1.0, 0.5)


func update_text():
	$Text.set_text(str(Round.get_round_count()) + " di " + str(GameLogic.get_max_round()))
