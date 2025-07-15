extends Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent().name == "EndMenu":
		$Text.set_text("Rigioca")
