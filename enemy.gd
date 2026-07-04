extends Area2D


@onready var bullet_scene = preload("res://bullet.tscn")

const BASE_SPEED = 500.0
const MAX_SPEED = 1800.0
var direction = Vector2(0,1)
var movement_bound_pad = 100
var max_y
var min_y

var max_health = 65.0 - 60.0;
var health = max_health;
var is_dead = false;

var total_timer_runs = 0;

const EXPLOSION_DURATION = 1.1


func _ready() -> void:
	add_to_group("enemy")
	
	min_y = movement_bound_pad
	max_y = Global.height - movement_bound_pad
	
	$Sprite2D.modulate = Color(2, 0.3, 0.4)
	
	position = Vector2(
		Global.width - 300,
		Global.height / 2
	)
	
	$EnemyTimer.start()
	Global.game_ended.connect(_on_game_end)



func _physics_process(delta: float) -> void:
	var speed = lerp(
		BASE_SPEED, 
		MAX_SPEED, 
		1 - health/max_health
	)

	if Global.game_status == 'active':
		
		# --- Normal movement ---
	
		position += direction * speed * delta;
		position.y = clamp(position.y, min_y, max_y)
		
		if position.y == max_y:
			direction = Vector2(0,-1);
		elif position.y == min_y:
			direction = Vector2(0,1);


func on_death():
	if (not is_dead):
		is_dead = true
		Global.game_ended.emit('win')
		
		Global.damage_flash(self)
		Global.death_explosion(self)
		Global.set_screen_shake(15)
		
		await get_tree().create_timer(Global.FLASH_DURATION).timeout
		$Sprite2D.hide()


func on_damage():
	Global.damage_flash(self)
	Global.set_screen_shake(4)


func _on_enemy_timer_timeout() -> void:
	var shoot_chance = 0.3 + 0.7 * (1 - health/max_health)
	if total_timer_runs > 5 and randf() < shoot_chance:
		var new_bullet = bullet_scene.instantiate()

		new_bullet.add_to_group('enemy')
		new_bullet.position = position
		
		get_tree().root.add_child(new_bullet)
		
	total_timer_runs += 1


func _on_game_end(result):
	$EnemyTimer.stop()
