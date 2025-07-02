extends Node

signal animation_done

@export var distance = Vector2(100, 0)
@export var duration = 0.4
var _target_node 

func get_target_node():
	return self._target_node

func set_target_node(target: Node):
	self._target_node = target
	
func start():
	var tween = create_tween()
	var start_pos = get_target_node().position
	var end_pos = start_pos - distance
	
	tween.tween_property(get_target_node(), "position", end_pos, self.duration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
	tween.parallel()
	tween.tween_property(get_target_node(), "modulate:a", 0.0, duration).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	tween.connect("finished", func(): self.animation_done.emit())
	
