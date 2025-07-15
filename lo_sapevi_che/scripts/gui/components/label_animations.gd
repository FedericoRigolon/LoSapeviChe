extends Node

signal animation_done

@export var duration = 1
var _target_node 

func get_target_node():
	return self._target_node

func set_target_node(target: Node):
	self._target_node = target
	
func start(delay: float = 0, is_entry: bool = true):
	var current_node = get_target_node()
	
	await get_tree().create_timer(delay).timeout
	
	var end_pos_x: float
	var end_opacity: float
	
	if is_entry:
		end_pos_x = current_node.get_parent().size.x / 2 - current_node.size.x / 2	# centro
		end_opacity = 1.0
	else:
		end_pos_x = 0	# sinistra
		end_opacity = 0.0
	
	var tween = create_tween()
	tween.tween_property(current_node, "position:x", end_pos_x, self.duration).set_trans(Tween.TRANS_QUAD if is_entry else Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT if is_entry else Tween.EASE_IN)
	tween.parallel().tween_property(current_node, "modulate:a", end_opacity, self.duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT if is_entry else Tween.EASE_IN)
	
	if(not is_entry):
		tween.connect("finished", func(): self.animation_done.emit())
