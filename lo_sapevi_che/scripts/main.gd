extends Node

func _on_menu_play_pressed() -> void:
	var menu = get_node("Menu")
	remove_child(menu)
	
	RoundFactory.start()
	await _create_rounds()
	
	var score = GameLogic.get_score()
	var win = GameLogic.win()
	print(score)
	print(win)
	GameLogic.reset()
	RoundFactory.reset()
	
	menu.play_pressed.disconnect(_on_menu_play_pressed)
	menu.play_pressed.connect(_on_end_menu_play_pressed)
	add_child(menu)
	if(win):
		menu.winner_menu()
	else:
		menu.loser_menu()

func _on_end_menu_play_pressed() -> void:
	get_tree().reload_current_scene()

func _create_rounds():
	const ROUNDS = 5
	
	for i in range(ROUNDS):
		var round = RoundFactory.create_round(i)
		add_child(round)
		await round.kill_me
		remove_child(round)
		round.queue_free()
