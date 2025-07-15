extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if self.get_parent().get_parent().get_name() == "TutorialPopup":
		$Text.set_text("Vai!")
	elif self.get_name() == "Nope":
		$Text.set_text("Annulla")
	else:
		$Text.set_text("Ricomincia")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
