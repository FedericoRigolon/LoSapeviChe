extends CommonUI

func _on_tree_entered() -> void:
	await super.fade_in($".")
	Utils.recursive_disable_buttons(self, true)
	await super.fade_in($TutorialPopup)
	Utils.recursive_disable_buttons($TutorialPopup, false)
	$Round1/Question.visible = true

func _on_tutorial_popup_game_start() -> void:
	await super.fade_out($TutorialPopup)
	$TutorialPopup.queue_free()
	Utils.recursive_disable_buttons(self,false)
	$TopBar/RetryButton.disabled = false
	$Round1.start()	
