extends Area2D


const SPEED = 2700.0
	
	
func _physics_process(delta: float) -> void:
	position.x += SPEED * delta
	if has_overlapping_areas(): print(get_overlapping_areas())
