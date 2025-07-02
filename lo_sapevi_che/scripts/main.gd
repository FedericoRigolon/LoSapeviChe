extends Node

func _on_menu_play_pressed() -> void:
	const ROUNDS = 5
	
	for i in range(ROUNDS):
		var round = RoundFactory.create_round(i)
		add_child(round)
		await round.kill_me
		remove_child(round)
		round.queue_free()
