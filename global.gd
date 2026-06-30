extends Node2D


var width
var height

const FLASH_DURATION = 0.05;


func _ready():
	var size = get_viewport_rect().size
	width = size.x
	height = size.y
	
	
func _on_timer_timeout():
	print('gurt')

func damage_flash(target):
	target.get_node('Sprite2D').material.set_shader_parameter('enabled', true)
	await get_tree().create_timer(FLASH_DURATION).timeout
	target.get_node('Sprite2D').material.set_shader_parameter('enabled', false)
