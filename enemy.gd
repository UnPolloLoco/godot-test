extends Area2D


const SPEED = 500.0
var direction = Vector2(0,1)
var movement_bound_pad = 100
var max_y
var min_y

var health = 10


func _ready() -> void:
	add_to_group("enemy")
	
	min_y = movement_bound_pad
	max_y = Global.height - movement_bound_pad
	
	modulate = Color(2, 0.3, 0.4)

	
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


func on_death():
	print('enemy DEAD')
	Global.damage_flash(self)
	await get_tree().create_timer(Global.FLASH_DURATION).timeout
	queue_free()

func on_damage():
	print('enenmy damaged')
	Global.damage_flash(self)
