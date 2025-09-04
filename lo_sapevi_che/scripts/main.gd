## Main script.
extends Node
class_name Main

## Connects some signal of get_window and calculate the top window.
func _ready() -> void:
	if OS.get_name() == "Web":
		get_window().focus_entered.connect(_on_window_focus_entered)
		get_window().focus_exited.connect(_on_window_focus_exited)

## When window is not in background anymore, it resumes the audio.
func _on_window_focus_entered() -> void:
	AudioManager.set_paused(false)

## When window goes in background, it pauses the audio.
func _on_window_focus_exited() -> void:
	AudioManager.set_paused(true)


## Resize viewport as viewportcontainer.
## Checks every frame the screen orientation and stops the game (mobile only).
func _process(_delta):
	$SubViewportContainer/SubViewport.size = $SubViewportContainer.size
	
	#var orientation = DisplayServer.screen_get_orientation()
	#if orientation == DisplayServer.SCREEN_PORTRAIT:
	#	$SubViewportContainer/SubViewport/RotateWarning.visible = true
	#	get_tree().paused = true
	#else:
	#	$SubViewportContainer/SubViewport/RotateWarning.visible = false
	#	get_tree().paused = false

## Put the game and the audio in pause.
func set_paused(paused: bool) -> void:
	if paused != get_tree().paused:
		get_tree().paused = paused
		AudioManager.set_paused(paused)

## URL is the "parent" of the actual URL.
## When "back" button is pressed on menu, calls the URL using javascript eval function.
## if the game is a webexport. Quits the application otherwise.
func _on_end_menu_back_pressed():
	if OS.get_name() == "Web":
		var URL = JavaScriptBridge.call("eval", "window.location.href.split('/').slice(0, -2).join('/');")
		JavaScriptBridge.call("eval", "top.location.href = '" + URL + "';")
	else:
		get_tree().quit()


## When "play" button is pressed, main menu gets killed and the gui scene is instantiated.
## Now the game can start (in v2, this method is never called)
func _on_menu_play_pressed() -> void:
	var menu = $SubViewportContainer/SubViewport.get_node("Menu")
	await menu.kill()
	$SubViewportContainer/SubViewport.remove_child(menu)
	menu.queue_free()
	_run()


## Main function of the game. Creates rounds, setups end menu and awaits until the game
## is over.
func _run():
	await get_tree().process_frame
	RoundFactory.start()
	#await startable
	await _create_rounds()

	#var score = GameLogic.get_score()
	var win = GameLogic.win()
	var perfect_win = false
	if win:
		perfect_win = GameLogic.perfect_win()

	var next_scene: Node
	if win:
		next_scene = preload("res://scenes/main_gui/menu/end_menu.tscn").instantiate()
		next_scene.set_win_type(perfect_win)
	else:
		next_scene = preload("res://scenes/main_gui/menu/end_menu2.tscn").instantiate()

	next_scene.back_pressed.connect(_on_end_menu_back_pressed)
	next_scene.play_pressed.connect(_on_reset)
	$SubViewportContainer/SubViewport.add_child(next_scene)


## Resets every singleton and reload the current scene.
## Called every time the game restarts.
func _on_reset():
	AudioManager.reset()
	GameLogic.reset()
	RoundFactory.reset()
	get_tree().reload_current_scene()


## Creates the correct number of rounds. Calls the factory, awaits the turn end
## and calls game_over.
func _create_rounds():
	var gui = preload("res://scenes/main_gui/gui.tscn").instantiate()
	gui.get_node("ResetPopup/SplitContainer/Go").pressed.connect(_on_reset)
	$SubViewportContainer/SubViewport.add_child(gui)
	$SubViewportContainer/SubViewport.move_child(gui, -1)
	for i in range(GameLogic.MAX_ROUND):
		var current_round = RoundFactory.create_round(i)
		gui.add_child(current_round)
		gui.move_child(current_round, -3)
		await current_round.kill_me
		gui.remove_child(current_round)
		current_round.queue_free()
	gui.game_over()


## Called when a child is added. It moves FullScreenButton in last position.
func _on_child_entered_tree(node: Node) -> void:
	if $SubViewportContainer/SubViewport.has_node("FullScreenButton"):
		$SubViewportContainer/SubViewport.move_child.call_deferred($SubViewportContainer/SubViewport/FullScreenButton, -1)
