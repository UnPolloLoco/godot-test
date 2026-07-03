extends Node2D


signal health_updated(team, health, max_health)
signal game_ended(result)

var width
var height

const FLASH_DURATION = 0.07;
const HEALTH_FLASH_DURATION = 0.07;
# Explosion duration is managed per-character

var game_status = 'active';
# 'active', 'win', or 'lose'

var camera


func _ready():
	var size = get_viewport_rect().size
	width = size.x
	height = size.y
	
	Global.game_ended.connect(_on_game_end)


func damage_flash(target):
	target.get_node('Sprite2D').material.set_shader_parameter('enabled', true)
	target.get_node('HitParticles').emitting = true
	
	await get_tree().create_timer(FLASH_DURATION).timeout
	
	if is_instance_valid(target):
		target.get_node('Sprite2D').material.set_shader_parameter('enabled', false)
		target.get_node('HitParticles').emitting = false
		
		
func death_explosion(target):
	target.get_node('DeathParticles').emitting = true
	
	await get_tree().create_timer(target.EXPLOSION_DURATION).timeout
	
	if is_instance_valid(target):
		target.get_node('DeathParticles').emitting = false
		

func health_bar_flash(target, original_color):
	var style = target.get_theme_stylebox('fill')

	style.bg_color = original_color * 4.0
	await get_tree().create_timer(HEALTH_FLASH_DURATION).timeout
	style.bg_color = original_color
	
	
func set_screen_shake(strength):
	if strength > camera.shake_strength:
		camera.shake_strength = strength


func _on_game_end(result):
	game_status = result
	print(result)
