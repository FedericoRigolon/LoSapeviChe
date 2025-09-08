## Main gui class, it contains every gui object.
extends CommonUI
class_name Gui


## Called when the game is over, it despawns the topbar text and the greenkid.
func game_over():
	super.fade_out($GreenKid)
	super.fade_out($TopBar/Text)


## Fades in and animations when it enters the scene tree.
func _on_tree_entered():
	await super.fade_in($".")
	$Round1/Question.visible = true
	await $Round1.first_entrance()
	$TopBar.text_first_entrance()
	$Round1.start()
	Utils.recursive_disable_buttons(self, false)


## Fades in and animations when it enters the scene tree.
## It spawns the tutorial popup too (only v1).
func _on_tree_entered_with_tutorial() -> void:
	Utils.recursive_disable_buttons(self, true)
	await super.fade_in($".")
	await super.fade_in($TutorialPopup)
	Utils.recursive_disable_buttons($TutorialPopup, false)


## Called when tutorial popup has to be despawned so the game can start.
## It enables buttons and setup things.
func _on_tutorial_popup_game_start() -> void:
	Utils.recursive_disable_buttons(self, true)
	await super.fade_out($TutorialPopup)
	$TutorialPopup.queue_free()
	$TopBar/RetryButton.disabled = false
	$Round1/Question.visible = true
	$Round1/Question._on_tree_entered()
	$TopBar.text_first_entrance()
	$Round1.start()
	Utils.recursive_disable_buttons(self, false)
