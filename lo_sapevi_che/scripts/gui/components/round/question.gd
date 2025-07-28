extends Label

class_name Question

var _score: int


func setup(text: String, score: int = 1):
	set_text(text)
	self._score = score


func set_score(score: int = 1):
	self._score = score


func get_score() -> int:
	return self._score


func _on_tree_entered() -> void:
	self.modulate.a = 0.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 0.5)


func kill() -> void:
	self.modulate.a = 1.0
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 0.0, 1.5)
	await tween.finished
	self.queue_free()
