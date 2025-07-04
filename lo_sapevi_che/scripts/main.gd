extends Node

func _on_menu_play_pressed() -> void:
	var menu = get_node("Menu")
	remove_child(menu)
	
	await _create_rounds()
	
	var win = GameLogic.win()
	var score = GameLogic.get_score()
	print(score)
	print(win)
	add_child(menu)

func _create_rounds():
	const ROUNDS = 5
	
	for i in range(ROUNDS):
		var round = RoundFactory.create_round(i)
		add_child(round)
		await round.kill_me
		remove_child(round)
		round.queue_free()
