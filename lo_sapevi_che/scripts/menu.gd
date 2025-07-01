extends Control

signal play_pressed

func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	play_pressed.emit()
