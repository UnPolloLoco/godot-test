extends Area2D


@onready var bullet_scene = preload("res://bullet.tscn")


const SPEED = 1100.0
var direction

var health = 10
var is_dead = false;


func _ready() -> void:
	add_to_group("ally")
	
	position = Vector2(
		300,
		Global.height / 2
	)
	
	modulate = Color(0, 1, 0)


func _physics_process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	); 
	
	position += direction.normalized() * SPEED * delta


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		
		# Shoot bullet
		if event.is_action_pressed('shoot'):
			var new_bullet = bullet_scene.instantiate()

			new_bullet.add_to_group('ally')
			new_bullet.position = position
			
			get_tree().root.add_child(new_bullet)



func on_death():
	if (not is_dead):
		is_dead = true
		print('player DEAD')
		
		Global.damage_flash(self)
		await get_tree().create_timer(Global.FLASH_DURATION).timeout
		queue_free()
	
	
func on_damage():
	print('player damaged')
	Global.damage_flash(self)
