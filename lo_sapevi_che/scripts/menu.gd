extends Control

signal play_pressed

func _ready() -> void:
	pass

func _on_play_pressed() -> void:
	play_pressed.emit()

func winner_menu() -> void:
	var background = preload("res://art/graphics/bg.png")
	if(background):
		$Background.texture = background

func loser_menu() -> void:
	var background = preload("res://art/graphics/white_man.png")
	if(background):
		$Background.texture = background
