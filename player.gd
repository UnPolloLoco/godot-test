extends Area2D


@onready var bullet_scene = preload("res://bullet.tscn")


const SPEED = 1100.0
var direction

const X_BOUNDS = [100, 1400]
const Y_MARGIN = 110
var min_x; var max_x
var min_y; var max_y

var max_health = 10.0;
var health = max_health;
var is_dead = false;

const EXPLOSION_DURATION = 0.4


func _ready() -> void:
	add_to_group("ally")
	
	position = Vector2(
		300,
		Global.height / 2
	)
	
	$Sprite2D.modulate = Color(0, 1, 0)
	
	min_y = Y_MARGIN
	max_y = Global.height - Y_MARGIN


func _physics_process(delta: float) -> void:
	var fps = (1/delta)
	if fps < 59.9: print(fps)
	
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down")
	); 
	
	if Global.game_status == 'active':
		position += direction.normalized() * SPEED * delta
		
		position.x = clamp(position.x, X_BOUNDS[0], X_BOUNDS[1])
		position.y = clamp(position.y, min_y, max_y)


func _input(event: InputEvent) -> void:
	if event is InputEventKey and Global.game_status == 'active':
		
		# Shoot bullet
		if event.is_action_pressed('shoot'):
			var new_bullet = bullet_scene.instantiate()

			new_bullet.add_to_group('ally')
			new_bullet.position = position
			
			get_tree().root.add_child(new_bullet)



func on_death():
	if (not is_dead):
		is_dead = true
		Global.game_ended.emit('lose')
		
		Global.damage_flash(self)
		Global.death_explosion(self)
		Global.set_screen_shake(10)
		
		await get_tree().create_timer(Global.FLASH_DURATION).timeout
		$Sprite2D.hide()
	
	
func on_damage():
	Global.damage_flash(self)
	Global.set_screen_shake(4)
