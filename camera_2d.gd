extends Camera2D


var hit_zoom_amount = 1.035
var tween


func _ready() -> void:
	Global.health_updated.connect(_on_health_update)
	

func _on_health_update(team, health, max_health):
	if team == 'ally':
		zoom = Vector2(hit_zoom_amount, hit_zoom_amount)
		
		if tween: tween.kill()
		tween = create_tween()

		tween.set_trans(Tween.TRANS_CUBIC)
		tween.set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "zoom", Vector2(1.0, 1.0), 0.3)
