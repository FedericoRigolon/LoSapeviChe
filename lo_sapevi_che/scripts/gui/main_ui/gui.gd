extends CommonUI
	
func game_over():
	super.fade_out($TopBar/Text)
	
func _on_tree_entered() -> void:
	await super.fade_in($".")
	Utils.recursive_disable_buttons(self, true)
	await super.fade_in($TutorialPopup)
	Utils.recursive_disable_buttons($TutorialPopup, false)

func _on_tutorial_popup_game_start() -> void:
	await super.fade_out($TutorialPopup)
	$TutorialPopup.queue_free()
	Utils.recursive_disable_buttons(self,false)
	$TopBar/RetryButton.disabled = false
	$Round1/Question.visible = true
	$Round1/Question._on_tree_entered()
	$TopBar.text_first_entrance()
	$Round1.start()


func _on_child_entered_tree(node: Node) -> void:
	# first call is animated and starts after tutorial popup, not here
	if node is Round and Round.get_round_count() > 1:
		$TopBar.update_text()
