extends Node2D


signal health_updated(team, health, max_health)
signal game_ended(result)

var width
var height

const FLASH_DURATION = 0.05;

var game_status = 'active';
# 'active', 'win', or 'lose'


func _ready():
	var size = get_viewport_rect().size
	width = size.x
	height = size.y
	
	Global.game_ended.connect(_on_game_end)


func damage_flash(target):
	target.get_node('Sprite2D').material.set_shader_parameter('enabled', true)
	await get_tree().create_timer(FLASH_DURATION).timeout
	if is_instance_valid(target):
		target.get_node('Sprite2D').material.set_shader_parameter('enabled', false)


func _on_game_end(result):
	game_status = result
	print(result)
