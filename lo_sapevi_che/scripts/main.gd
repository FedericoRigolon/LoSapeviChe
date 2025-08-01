extends Node

const URL = "https://spreafico.net"


func _on_end_menu_back_pressed():
	if OS.get_name() == "Web":
		var js = Engine.get_singleton("JavaScriptBridge")
		js.call("eval", "window.location.href = '" + URL + "';")
	else:
		get_tree().quit()


func _on_menu_play_pressed() -> void:
	var menu = get_node("Menu")
	await menu.kill()
	remove_child(menu)
	menu.queue_free()

	RoundFactory.start()
	await _create_rounds()

	#var score = GameLogic.get_score()
	var win = GameLogic.win()

	var next_scene: Node
	if win:
		next_scene = preload("res://scenes/main_gui/menu/end_menu.tscn").instantiate()
	else:
		next_scene = preload("res://scenes/main_gui/menu/end_menu2.tscn").instantiate()

	next_scene.back_pressed.connect(_on_end_menu_back_pressed)
	next_scene.play_pressed.connect(_on_reset)
	add_child(next_scene)


func _on_reset():
	AudioManager.reset()
	GameLogic.reset()
	RoundFactory.reset()
	get_tree().reload_current_scene()


func _create_rounds():
	var gui = preload("res://scenes/main_gui/gui.tscn").instantiate()
	gui.get_node("ResetPopup/SplitContainer/Go").pressed.connect(_on_reset)
	add_child(gui)
	for i in range(GameLogic.MAX_ROUND):
		var current_round = RoundFactory.create_round(i)
		gui.add_child(current_round)
		gui.move_child(current_round, -3)
		await current_round.kill_me
		gui.remove_child(current_round)
		current_round.queue_free()
	gui.game_over()


func _on_child_entered_tree(node: Node) -> void:
	if has_node("FullScreenButton"):
		move_child.call_deferred($FullScreenButton, -1)
