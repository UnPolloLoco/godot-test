extends ColorRect


@onready var star_scene = preload("res://star.tscn")


var star_count = 70
var star_size_range = [0.2, 3]


func _ready() -> void:
	for i in star_count:
		var new_star = star_scene.instantiate()
		add_child(new_star)
		
		# --- Position star ---
		
		new_star.position = Vector2(
			randi_range(0, Global.width),
			randi_range(0, Global.height)
		)
		new_star.position -= position # offset bg position
		
		# --- Resize star ---
		
		var new_star_size = randf_range(
			star_size_range[0], 
			star_size_range[1]
		)

		new_star.size = Vector2(new_star_size, new_star_size)
		
		# --- Color star ---
		
		new_star.color = Color.from_hsv(
			randi_range(-180, 58) / 360.0, 
			0.2, 
			1.0,
			1.0
		)
