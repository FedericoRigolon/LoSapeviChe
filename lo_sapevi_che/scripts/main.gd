extends Node

signal round_finished

func _on_menu_play_pressed() -> void:
	const ROUNDS = 5
	
	for i in range(ROUNDS):
		var round = RoundFactory.create_round(i)
		add_child(round)
		await round.finished
		remove_child(round)
		round.queue_free()

func _on_round_finished() -> void:
	self.round_finished.emit()
