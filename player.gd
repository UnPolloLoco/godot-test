extends Area2D


@onready var bullet_scene = preload("res://bullet.tscn")


const SPEED = 900.0
var direction


func _ready() -> void:
	position = Vector2(
		300,
		Global.width / 2
	)


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
			get_tree().root.add_child(new_bullet)
			
			new_bullet.position = position
			
			print()
