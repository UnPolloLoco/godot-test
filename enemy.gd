extends Area2D


const SPEED = 500.0
var direction = Vector2(0,1)
var movement_bound_pad = 100
var max_y
var min_y


func _ready() -> void:
	min_y = movement_bound_pad
	max_y = Global.height - movement_bound_pad
	
	position = Vector2(
		Global.width - 300,
		Global.height / 2
	)



func _physics_process(delta: float) -> void:
	position += direction * SPEED * delta;

	position.y = clamp(position.y, min_y, max_y)
	
	if position.y == max_y:
		direction = Vector2(0,-1);
	elif position.y == min_y:
		direction = Vector2(0,1);
