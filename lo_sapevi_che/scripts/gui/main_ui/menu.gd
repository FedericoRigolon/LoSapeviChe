extends CommonUI

@export var type: int

signal play_pressed
signal back_pressed


func _on_play_pressed() -> void:
	play_pressed.emit()


func _on_back_pressed() -> void:
	back_pressed.emit()


func _on_tree_entered() -> void:
	match self.type:
		1:
			AudioManager.win()
		2:
			AudioManager.lose()
	var tween = create_tween()
	self.modulate.a = 0.0
	tween.tween_property(self, "modulate:a", 1.0, 1.3)


func kill():
	var tween = create_tween()
	self.modulate.a = 1.0
	tween.tween_property(self, "modulate:a", 0.0, 0.4)
	await tween.finished
