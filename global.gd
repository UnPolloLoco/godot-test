extends Node2D


var width
var height


func _ready():
	var size = get_viewport_rect().size
	width = size.x
	height = size.y
