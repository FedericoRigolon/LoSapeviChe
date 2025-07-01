extends Node

var round_scene = preload("res://scenes/round.tscn")

func _on_menu_play_pressed() -> void:
	print("scimpanzini bananini")
	round_factory(1)

func round_factory(round_number):
	match round_number:
		1:
			print("creating round 1")
		2:
			print("creating round 2")
		3:
			print("creating round 3")
		4:
			print("creating round 4")
		5:
			print("creating round 5")
		_:
			print("error")
