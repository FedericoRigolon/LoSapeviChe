## Script that manages every game menu (start menu, win menu, lose menu, ...).
extends CommonUI
class_name Menu

## Describes the type of menu (1 = win, 2 = lose)
@export var type: int

## Emitted when the "play" button is pressed.
signal play_pressed

## Emitted when the "back" button is pressed.
signal back_pressed


## Emits the play_pressed signal.
func _on_play_pressed() -> void:
	play_pressed.emit()


## Emits the back_pressed signal.
func _on_back_pressed() -> void:
	back_pressed.emit()


## Sets the text for in order to the type of win.
## Default win is the 51% one, the text is set in the editor.
## The 100% win text is set here after a check on the perfect_win variable.
func set_win_type(perfect_win = false):
	if self.type != 1:
		return

	if perfect_win:
		$Text.set_text(
			"Hai completato il gioco! Rigioca per scoprire altre curiosità su frutta e verdura."
		)


## Checks what tyoe of menu it is (win menu or lose menu) and plays the correct audio
## and animation.
func _on_tree_entered() -> void:
	match self.type:
		1:
			AudioManager.win()
		2:
			AudioManager.lose()
	var tween = create_tween()
	self.modulate.a = 0.0
	tween.tween_property(self, "modulate:a", 1.0, 1.3)


## Fades out itself.
func kill():
	var tween = create_tween()
	self.modulate.a = 1.0
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	await tween.finished
