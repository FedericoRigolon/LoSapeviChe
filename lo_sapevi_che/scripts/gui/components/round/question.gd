## This class represents a question. It extends a label.
extends Label

class_name Question

## Score of questio (default is 1).
var _score: int


## Setups label text and score.
func setup(text: String, score: int = 1):
	set_text("\n"+text)
	self._score = score


## Setter for score.
func set_score(score: int = 1):
	self._score = score


## Getter for score.
func get_score() -> int:
	return self._score


## Changes visibility with an animation.
func _on_tree_entered() -> void:
	self.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)


## Kills itself with an animation.
func kill() -> void:
	self.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.25).set_delay(1.75)
	await tween.finished
	self.queue_free()
