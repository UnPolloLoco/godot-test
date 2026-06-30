extends Area2D


@onready var bullet_scene = preload("res://bullet.tscn")


var speed
var direction

var base_speed = 2200

var ally_power_magnifier = 1.2
var enemy_power_magnifier = 0.67


func _ready():
	if is_in_group("ally"):
		direction = Vector2(1,0)
		speed = base_speed * ally_power_magnifier
		scale.x *= ally_power_magnifier
		modulate = Color(1.8, 2.5, 1)
		
	elif is_in_group("enemy"):
		direction = Vector2(-1,0)
		speed = base_speed * enemy_power_magnifier
		scale.x *= enemy_power_magnifier
		modulate = Color(2.5, 0.7, 0.6)
		
	else:
		print("A bullet doesn't have a team group!")
	

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	
	if has_overlapping_areas():
		for victim in get_overlapping_areas():
			var self_is_enemy = is_in_group("enemy")
			var victim_is_enemy = victim.is_in_group("enemy")
			
			if self_is_enemy != victim_is_enemy:
				# If bullet hit someone on the other team...
				queue_free()
				
				victim.health -= 1
				if (victim.health <= 0):
					victim.on_death()
				else:
					victim.on_damage()
